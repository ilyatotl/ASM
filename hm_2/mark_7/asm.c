#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

char a[100000], b[100000];
bool exist[128];

extern int get_len(int len_a, int len_b);

int main(int argc, char* argv[]) {
    if (argc != 4) {
        printf("3 files needed\n");
        return 0;
    }
    FILE *inputFileA, *inputFileB, *outputFile;
    
    if ((inputFileA = fopen(argv[1], "rb")) == NULL) {
        printf("Cannot open input file A");
        return 0;
    } 
    
    if ((inputFileB = fopen(argv[2], "rb")) == NULL) {
        printf("Cannot open input file B");
        return 0;
    } 
    
    if ((outputFile = fopen(argv[3], "wb")) == NULL) {
        printf("Cannot open output file");
        return 0;
    } 

    int len_a = 0, len_b = 0, ch, last_idx, i;
    do {
        ch = fgetc(inputFileA);
        a[len_a++] = ch;
    } while(ch != -1);
    a[len_a - 1] = '\0';
    len_a--;
    fclose(inputFileA);
    
    do {
        ch = fgetc(inputFileB);
        b[len_b++] = ch;
    } while(ch != -1);
    b[len_b - 1] = '\0';
    len_b--;
    fclose(inputFileB);
    
    last_idx = get_len(len_a, len_b);
    for (i = 0; i <= last_idx; i++) {
        if (exist[i]) {
            fprintf(outputFile, "%c", i);
        }
    }
    fclose(outputFile);
    return 0;
}
