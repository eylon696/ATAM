#include<stdio.h>
#include<stdlib.h>


extern int getDiffMin(int *mat[], int size , int *num1 , int *num2);

int main()
{
    int diff , i, j , num1 , num2;
    int **mat = (int **)malloc(sizeof(int *) * 4); 
    for (i = 0; i < 4; i++)
        mat[i] = (int *)malloc(sizeof(int) * 4);
    for (i = 0; i < 4; i++)
        for (j = 0; j < 4; j++)
            mat[i][j] = (i*j) - (5 * i) - (14 * j);
    for (i = 0; i < 4; i++)
    {
        for (j = 0; j < 4; j++)
            printf("%d\t", mat[i][j]);
        printf("\n");
    }
    diff = getDiffMin(mat, 4 , &num1 , &num2);
    printf("\nminDiff == |(%d)-(%d)| = %d", num1 , num2 , diff);
    for (i = 0; i < 4; i++)
        free(mat[i]);
    free(mat);
    return 0;
}
