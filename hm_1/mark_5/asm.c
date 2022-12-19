#include <stdio.h>
#include <stdlib.h>

int a[100000], b[100000];


int get_size(int a_sz, int x) {
    int b_sz = 0, i = 0;
    for (i = 0; i < a_sz; ++i) {
	if (a[i] % x == 0) {
	    ++b_sz;
	}
    }
    return b_sz;
}

int main(int argc, char* argv[]) {
    int a_sz = argc - 2, x = atoi(argv[argc - 1]), b_sz = 0, idx = 0, i;
    for (i = 0; i < a_sz; ++i) {
	a[i] = atoi(argv[i + 1]);
    }
    b_sz = get_size(a_sz, x);
    for (i = 0; i < a_sz; ++i) {
	if (a[i] % x == 0) {
	    b[idx] = a[i];
	    ++idx;
	}
    }
    for (i = 0; i < b_sz; ++i) {
	printf("%d ", b[i]);
    }
    printf("\n");
    return 0;
}
