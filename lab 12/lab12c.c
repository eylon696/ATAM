#include<stdio.h>

double mysqr(double x)
{
  return x*x;
} // mysqr

extern double find_delta1(double (*f)(double),double x0, double eps);
extern double find_delta2(double (*f)(double),double x1, double x2,double h, double eps);

int main()
{
  double x1 = -0.5, x2 = 1.0, x, eps=0.001, h=0.01;

  x = (x1+x2)/2.0;
  printf("\nfind_delta1(mysqr,%lf, %lf) = %lf\n", x, eps,
  find_delta1(mysqr,x,eps));
//NOTE :  THE FOLLOWING LINE IS UPDATED
  printf("\nfind_delta2(mysqr, %lf, %lf,%lf, %lf) = %lf\n",
      x, x2, h, eps, find_delta2(mysqr,x, x2, h, eps));
return 0;
} // main


