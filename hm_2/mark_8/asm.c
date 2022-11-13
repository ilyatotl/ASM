#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

char a[100000], b[100000];
bool exist[128];

extern int get_len(int len_a, int len_b);

int main(int argc, char* argv[]) {
    FILE *inputFileA, *inputFileB, *outputFile;
    int len_a = 0, len_b = 0, ch, last_idx, i;
    if (argc == 1) {
    	inputFileA = fopen("random_inputA.txt", "wb");
    	inputFileB = fopen("random_inputB.txt", "wb");
    	outputFile = fopen("random_output.txt", "wb");
    	len_a = rand() % 99999 + 1;
    	len_b = rand() % 99999 + 1;
    	for (i = 0; i < len_a; i++) {
    	    a[i] = (char)((rand() + clock()) % 64 + 32);
    	    fprintf(inputFileA, "%c", a[i]);
    	}
    	for (i = 0; i < len_b; i++) {
    	    b[i] = (char)((rand() + clock()) % 64 + 32);
    	    fprintf(inputFileB, "%c", b[i]);
    	}
    	printf("Two strngs were generated.\n");
    }
    else if (atoi(argv[1]) == 1) {
    	do {
        ch = getc(stdin);
        a[len_a++] = ch;
    	} while(ch != -1);
    	a[len_a - 1] = '\0';
    	len_a--;
    }
    else {
    	if (argc != 5) {
     	   printf("3 files needed\n");
     	   return 0;
    	}
    
    	if ((inputFileA = fopen(argv[2], "rb")) == NULL) {
    	    printf("Cannot open input file A");
    	    return 0;
    	} 
    
    	if ((inputFileB = fopen(argv[3], "rb")) == NULL) {
    	    printf("Cannot open input file B");
    	    return 0;
    	} 
    
    	if ((outputFile = fopen(argv[4], "wb")) == NULL) {
    	    printf("Cannot open output file");
   	     return 0;
   	 } 

    	do {
   	     ch = fgetc(inputFileA);
    	    a[len_a++] = ch;
    	} while(ch != -1);
    	a[len_a - 1] = '\0';
   	len_a--;
    
   	 do {
    	    ch = fgetc(inputFileB);
    	    b[len_b++] = ch;
    	} while(ch != -1);
    	b[len_b - 1] = '\0';
    	len_b--;
    }
    clock_t start, end;
    start = clock();
    for (i = 0; i < 10000; i++) {
    	last_idx = get_len(len_a, len_b);
    }
    end = clock();
    for (i = 0; i <= last_idx; i++) {
        if (argc == 1 || atoi(argv[1]) != 1) {
            fprintf(outputFile, "%c", i);
        } else {
            fprintf(stdin, "%c", i);
        }
    }
    printf("\n");
    printf("Time, the pogramm was working: %ld ms\n", (end - start) / 1000);
    if (argc == 1 || atoi(argv[1]) != 1) {
        fclose(outputFile);
    	fclose(inputFileA);
    	fclose(inputFileB);
    }
    return 0;
}
