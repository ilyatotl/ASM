extern int a[];

int get_size(int a_sz, int x) {
    int b_sz = 0, i = 0;
    for (i = 0; i < a_sz; ++i) {
	if (a[i] % x == 0) {
	    ++b_sz;
	}
    }
    return b_sz;
}
