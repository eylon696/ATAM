#include <stdio.h>
extern long double vector_length(long double arr[], int n);
 void main() 
{
int i;
long double x, arr[4] = {1.0, 2.0, 3.0, 4.0};
x = vector_length(arr, 4);
printf("The length of the vector: ");
for(i=0;i<4;i++) 
	printf("%Lf  ", arr[i]);
printf(" is: %Lf\n", x);
}
