#include <stdio.h>
#include <stdlib.h>

extern double expon(double x); 

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("2 files needed\n");
        return 0;
    }
    FILE *inputFile, *outputFile;
    
    if ((inputFile = fopen(argv[1], "r")) == NULL) {
        printf("Cannot open input file\n");
        return 0;
    } 
    
    if ((outputFile = fopen(argv[2], "w")) == NULL) {
        printf("Cannot open output file\n");
        return 0;
    }
    
    double x;
    fscanf(inputFile, "%lf", &x);
    fclose(inputFile);
    if (x == 0) {
        fprintf(outputFile, "Invalid value\n");
        fclose(outputFile);
        return 0;
    }
    if (x > 10) {
    	fprintf(outputFile, "1.0000\n");
    	fclose(outputFile);
    	return 0;
    } else if (x < -10) {
        fprintf(outputFile, "-1.0000\n");
        fclose(outputFile);
        return 0;
    }
    
    double pos = expon(x), neg = expon(-x);
    fprintf(outputFile, "%f\n", (pos + neg) / (pos - neg));
    fclose(outputFile);
}
