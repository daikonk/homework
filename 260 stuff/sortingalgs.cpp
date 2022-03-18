#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>

#define SIZE 10

using namespace std;
  

int partition(int arr[], int low, int high);

void swap(int *x, int *y) 
{ 
    int temp = *x; 
    *x = *y; 
    *y = temp; 
}

void quickSort(int arr[], int low, int high) 
{

    if (low < high)
    {

        int mid = partition(arr, low, high);

        quickSort(arr, low, mid - 1);
        quickSort(arr, mid + 1, high);

    }

}


//  need separate function because the quickSort is recursive, if function is inbedded the mid point variable will be overwritten //
int partition(int arr[], int low, int high)
{

    int pivot = arr[high];
    int i = low - 1;

    for (int j = low; j <= high - 1; j++)
    {

        if (arr[j] < pivot)
        {

            i++;
            swap(&arr[i], &arr[j]);

        }


    }

    swap(&arr[i + 1], &arr[high]);
    return i + 1;

}

void merge(int arr[], int low, int mid, int high)
{

    int p = mid - low + 1;
    int q = high - mid;

    int subArrOne[p], subArrTwo[q];

    for (int i = 0; i < p; i++)
    {

        subArrOne[i] = arr[low + i];
        

    }
    for (int j = 0; j < q; j++)
    {

        subArrTwo[j] = arr[mid + 1 + j];

    }

    int i = 0, j = 0, k = low;

    while(i < p && j < q)
    {

        if (subArrOne[i] <= subArrTwo[j])
        {

            arr[k] = subArrOne[i];
            i++;

        }
        else 
        {

            arr[k] = subArrTwo[j];
            j++;

        }
        k++;

    }

    while(i < p)
    {

        arr[k] = subArrOne[i];
        i++;
        k++;

    }
    while(j < q)
    {

        arr[k] = subArrTwo[j];
        j++;
        k++;

    }

}

void mergeSort(int arr[], int low, int high)
{

    if (low < high)
    {

        int mid = low + (high - low) / 2;
        mergeSort(arr, low, mid);
        mergeSort(arr, mid + 1, high);

        merge(arr, low, mid, high);

    }

}

void countingSort(int arr[], int size)
{

    int max = arr[0];
    int output[size];

    for (int i = 1; i < size + 1; i++)
    {

        if (arr[i] > max)
        {

            max = arr[i];

        }

    }

    int count[max + 1];

    for (int i = 0; i <= max; i++)
    {

        count[i] = 0;

    }

    for (int i = 0; i < size + 1; i++)
    {

        count[arr[i]]++;

    }

    for (int i = 1; i <= max; i++)
    {

        count[i] += count[i - 1];

    }

    for (int i = size; i >= 0; i--) 
    {

        output[count[arr[i]] - 1] = arr[i];
        count[arr[i]]--;

    }

    for (int i = 0; i < size + 1; i++)
    {

        arr[i] = output[i];

    }
    
}


void printArray(int arr[], int size) 
{  
    for (int i=0; i < size; i++) 
        cout << arr[i] << " "; 
    cout << endl; 
}

void fillArray(int arr[], int size)
{

    for (int i = 0; i < size; i++)

        // Random number index smaller for counting sort :D
        arr[i] = rand() % 20 + 1;

}

int main ()
{

    int arr[SIZE];

    srand(time(NULL));

    fillArray(arr, SIZE);
    cout << "Array configuration pre-sort (Quick Sort)" << endl;
    printArray(arr, SIZE);
    cout << endl;

    cout << "Array configuration post-sort (Quick Sort)" << endl;
    quickSort(arr, 0, SIZE - 1);
    printArray(arr, SIZE);
    cout << endl << endl;


    fillArray(arr, SIZE);
    cout << "Array configuration pre-sort (Merge Sort)" << endl;
    printArray(arr, SIZE);
    cout << endl;

    cout << "Array configuration post-sort (Merge Sort)" << endl;
    mergeSort(arr, 0, SIZE - 1);
    printArray(arr, SIZE);
    cout << endl << endl;


    fillArray(arr, SIZE);
    cout << "Array configuration pre-sort (counting Sort)" << endl;
    printArray(arr, SIZE);
    cout << endl;

    cout << "Array configuration post-sort (counting Sort)" << endl;
    countingSort(arr, SIZE - 1);
    printArray(arr, SIZE);
    cout << endl;

}