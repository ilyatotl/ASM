#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern double expon(double x); 

int main(int argc, char* argv[]) {
    FILE *inputFile, *outputFile;
    double x;
    clock_t start, end;
    if (argc == 1) {
        srand(time(NULL));
    	x = (double)(rand() * 10) / RAND_MAX + rand() % 5;
    	printf("Number %f was generated\n", x);
    } else if (argc == 2) {
        x = atof(argv[1]);
    } else if (argc == 3) {
        if ((inputFile = fopen(argv[1], "r")) == NULL) {
            printf("Cannot open input file\n");
            return 0;
        }
        if ((outputFile = fopen(argv[2], "w")) == NULL) {
            printf("Cannot open output file\n");
            return 0;
        }
        fscanf(inputFile, "%lf", &x);
        fclose(inputFile);
    } else {
        printf("Invalid numbers of arguments\n");
    }
    
    if (x == 0) {
        if (argc == 3) {
            fprintf(outputFile, "Invalid value\n");
            fclose(outputFile);
        } else {
            printf("Invalid value\n");
        }
        return 0;
    }
    if (x > 10) {
        if (argc == 3) {
    	    fprintf(outputFile, "1.0000\n");
    	    fclose(outputFile);
    	} else {
    	    printf("1.0000\n");
    	}
    	printf("The programm was working 0 ms\n");
    	return 0;
    } else if (x < -10) {
        if (argc == 3) {
    	    fprintf(outputFile, "-1.0000\n");
    	    fclose(outputFile);
    	} else {
    	    printf("-1.0000\n");
    	}
    	printf("The programm was working 0 ms\n");
        return 0;
    }
    double ans, pos, neg;
    start = clock();
    for (int i = 0; i < 10000000; i++) {
    	pos = expon(x);
    	neg = expon(-x);
    	ans = (pos + neg) / (pos - neg);
    }
    end = clock();
    if (argc == 3) {
        fprintf(outputFile, "%f\n", ans);
        fclose(outputFile);
    } else {
        printf("%f\n", ans);
    }
    printf("The programm was working %ldms\n", (end - start) / 1000);
}
