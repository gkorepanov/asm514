#include<unistd.h>
#include<sys/syscall.h>
int main() {
	int i;
	for (i = 0; i < 12000000; i++) {
		syscall(SYS_write, 1, "Hello world!\n", 13);
	}
	syscall(SYS_exit, 0);
	return 0;
}
