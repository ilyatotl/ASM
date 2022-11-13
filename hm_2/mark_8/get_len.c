#include <stdbool.h>

extern char a[];
extern char b[];
extern bool exist[];

int get_len(int len_a, int len_b) {
    int i = 0, last_idx = 0;
    for (i = 0; i < len_a; i++) {
        exist[a[i]] = true;
    }
    for (i = 0; i < len_b; i++) {
        exist[b[i]] = true;
    }
    for (i = 0; i < 128; i++) {
        if (exist[i]) {
            last_idx = i;
        }
    }
    return last_idx;
}
