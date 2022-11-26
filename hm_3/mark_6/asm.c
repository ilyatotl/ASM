#include <stdio.h>
#include <stdlib.h>

double expon(double x) {
    double res = 1, deg = 1, fact = 1;
    for (int i = 1; i <= 20; i++) {
        deg *= x;
        fact *= i;
        res += deg / fact;
    }
    return res;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Invalid numbers of arguments\n");
        return 0;
    }
    double x = atof(argv[1]);
    if (x == 0) {
        printf("Invalid value\n");
        return 0;
    }
    if (x > 10) {
    	printf("1.0000\n");
    	return 0;
    } else if (x < -10) {
        printf("-1.0000\n");
        return 0;
    }
    
    double pos = expon(x), neg = expon(-x);
    printf("%f\n", (pos + neg) / (pos - neg));
}
