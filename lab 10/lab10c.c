#include <stdio.h>
#include <stdlib.h>

int**  mallocAndInitMat(int n, int m, int (*getVal)(int, int));
int mulfunc(int i, int j)
{ 
return (i*j);
}

void main() 
{
int ** mat, i, n, m,j;
printf("\nPlease enter Matrix size (rows and cols)\n");
scanf("%d%d",&n, &m);
mat = mallocAndInitMat (n, m, mulfunc);   
if(!mat) 
{
	printf("Memory Allocation Failed\n");
	return;
} 
printf("\nThe Numbers in the allocated matrix are:\n");
for(i=0; i<n; i++)  
{   
for(j=0; j< m; j++) printf("%d\t", mat[i][j]);
printf("\n");  
}
return;
} 
