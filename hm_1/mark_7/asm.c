#include <stdio.h>
#include <stdlib.h>

int a[100000], b[100000];


extern int get_size(int a_sz, int x);

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("2 files needed\n");
        return 0;
    }
    FILE *inputFile, *outputFile;
    
    if ((inputFile = fopen(argv[1], "rb")) == NULL) {
        printf("Cannot open input file\n");
        return 0;
    } 
    
    if ((outputFile = fopen(argv[2], "wb")) == NULL) {
        printf("Cannot open output file\n");
        fclose(inputFile);
        return 0;
    } 


    int a_sz, x, b_sz = 0, idx = 0, i;
    fscanf(inputFile, "%d", &a_sz);
    
    for (i = 0; i < a_sz; ++i) {
	fscanf(inputFile, "%d", &a[i]);
    }
    fscanf(inputFile, "%d", &x);
    b_sz = get_size(a_sz, x);
    for (i = 0; i < a_sz; ++i) {
	if (a[i] % x == 0) {
	    b[idx] = a[i];
	    ++idx;
	}
    }
    for (i = 0; i < b_sz; ++i) {
	fprintf(outputFile, "%d ", b[i]);
    }
    fprintf(outputFile, "\n");
    fclose(inputFile);
    fclose(outputFile);
    return 0;
}
