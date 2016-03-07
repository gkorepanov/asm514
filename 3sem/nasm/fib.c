#include<stdio.h>
#include<stdlib.h>
/* r = m * v */
int apply(double* m, double* v, double* r, size_t size) {
	int i, j;
	for(i = 0; i < size; i++ ) {
		*(r+i) = 0;
		for (j = 0; j < size; j++ ) {
			*(r+i) += *(m+size*i+j) * (*(v+j));
		}
	}
	return 0;
}

int main(int argc, char* argv[]) {
	int n = 1;
	int i = 0;
	int j = 0;
	double m[] = {1, 1, 1, 0};
	double v[] = {1, 7};
	double r[2];
	if( argc > 1) {
		n = atoi(argv[1]);
	}
	for(i = 0; i < n; i++ ) {
		apply(m, v, r, 2);
		for(j = 0; j < 2; j++ ) {
			v[j] = r[j];
		}
	}
	for(j = 0; j < 2; j++ ){
		printf("%lf\n", v[j]);
	}
	return 0;
}
	

