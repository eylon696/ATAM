#include <stdio.h>
extern float vector_length(float arr[], int n);
 void main() 
{
int i;
float x, arr[4] = {1.0, 2.0, 3.0, 4.0};
x = vector_length(arr, 4);
printf("The length of the vector: ");
for(i=0;i<4;i++) 
	printf("%f  ", arr[i]);
printf(" is: %f\n", x);
}
