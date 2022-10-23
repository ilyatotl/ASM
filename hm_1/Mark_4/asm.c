#include <stdio.h>
#include <stdlib.h>

int a[100000], b[100000];

int main(int argc, char* argv[]) {
    int a_sz = argc - 2, x = atoi(argv[argc - 1]), b_size = 0, idx = 0, i;
    for (i = 0; i < a_sz; ++i) {
	a[i] = atoi(argv[i + 1]);
    }
    for (i = 0; i < a_sz; ++i) {
	if (a[i] % x == 0) {
	    ++b_size;
	}
    }
    for (i = 0; i < a_sz; ++i) {
	if (a[i] % x == 0) {
	    b[idx] = a[i];
	    ++idx;
	}
    }
    for (i = 0; i < b_size; ++i) {
	printf("%d ", b[i]);
    }
    printf("\n");
    return 0;
}
