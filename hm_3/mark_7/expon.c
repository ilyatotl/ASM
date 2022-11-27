double expon(double x) {
    double res = 1, deg = 1, fact = 1;
    for (int i = 1; i <= 20; i++) {
        deg *= x;
        fact *= i;
        res += deg / fact;
    }
    return res;
}
