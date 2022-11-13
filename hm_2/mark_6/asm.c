#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

char a[100000], b[100000];
bool exist[128];

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

int main() {
    int len_a = 0, len_b = 0, ch, last_idx, i;
    do {
        ch = getc(stdin);
        a[len_a++] = ch;
    } while(ch != -1);
    a[len_a - 1] = '\0';
    len_a--;
    
    last_idx = get_len(len_a, len_b);
    for (i = 0; i <= last_idx; i++) {
        if (exist[i]) {
            printf("%c", i);
        }
    }
    printf("\n");
    return 0;
}
