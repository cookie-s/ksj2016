#include <assert.h>
#include <stdio.h>

void mmul(size_t m, size_t n, size_t p, const double a[m][n], const double b[n][p], double c[m][p]);

int main(void) {
    double a[2][4] = {
          {21.64, 5.88, -14.4, -2.15},
            {12.3, 3.77, -18.1, 5.06}
    };
    double b[4][3] = {
          {-2.23, -5.74, 9.37},
            {-6.05, 20.1, 5.28},
              {24.9, -4.58, 14.9},
                {-4.39, 9.55, -0.869}
    };
    double c[2][3];
    mmul(2, 4, 3, a, b, c);

    printf("%f %f %f\n", c[0][0], c[0][1], c[0][2]);
    printf("%f %f %f\n", c[1][0], c[1][1], c[1][2]);
    return 0;
}
