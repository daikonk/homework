#include <stdlib.h>
#include <stdio.h>

int arrayAddress(int row, int col, int ncol, int arr[][ncol]) {

    return arr + col + row * ncol;

};

int main() {

    int array[3][5] = {{1,2,3,4,5},{6,7,8,9,10},{11,12,13,14,15}};
    int row, col;

    printf("Enter row and col [0..2] & [0..4] : \n");
    scanf("%d %d", &row, &col);

    printf("%d", arrayAddress(row, col, 5, array));


    return 0;

};