#include <stdio.h>
#include <stdlib.h>
extern void sum_col(int n, int m, long int *matrix[], long int new_col[]);
int main() {
  int n = 4, m = 3, i, j;
  long int *matrix[4];
  long int new_col[3];  
  for(i=0; i < n; i++)
     matrix[i] = (long int *)malloc(m*sizeof(long int));
  for(i=0; i < n; i++)
    for(j=0; j < m; j++)
       matrix[i][j] = 100*i+j;
  sum_col(n, m, matrix, new_col);
  printf("matrix:\n");    
  for(i=0; i < n; i++)
  {
    for(j=0; j < m; j++)
	   printf("%8ld",matrix[i][j]); 
    printf("\n");
  } // for
  printf("new_col:\n");    
  for(i=0; i < m; i++)
     printf("%8ld",new_col[i]); 
 return 0;
} // main
