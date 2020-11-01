#include <stdio.h>
#include <math.h>
extern double find_delta(double (*fp)(double), double x0,double epsilon, double range);
void main()  
{ 
  double x0, x, epsilon = 0.0001, range = 0.00001;
  int i;
  x0 = 0.25;
  for(i=1; i <= 3; i++)
  {
      x = i*x0;
      printf("sin: delta(%lf) =  %lf, range = %lf\n", x, find_delta(sin, x, epsilon, range), range); 
  } // for 
} // main
