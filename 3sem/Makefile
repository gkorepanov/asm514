LDFLAGS=-dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc 


hello: hello.o mylib.o
	ld $(LDFLAGS) -o $@  $^ 
series: series.o
	ld $(LDFLAGS) -o $@  $^ -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc 

%.o:%.nasm
	nasm -g -f elf64 $< -o $@
