#include <stdio.h>
#define N 10

extern  int  HardEven(int arr1[], int arr2[], int size);

int main()
{
int arr1[N], arr2[N], i, size;
printf("\Please enter %d numbers \n", N);
for( i=0; i<N; i++) 
	scanf("%d", &arr1[i]);
size = HardEven(arr1, arr2, N);
printf("\nThere are %d Hard-Even numbers in your input:\n",size);
for( i=0; i<size; i++) 
	printf("%d  ", arr2[i]);
printf("\n");
	return 0;
}
