//
// Created by BrunoSR on 10/3/2018.
//
#include <stdio.h>
#include <iomanip>
#include <iostream>
#include <random>
#include <ctime>
#include <array>
using namespace std;

int arr1[100];					// global variables
int arr2[1000];
int arr3[10000];
int numberOfComparisons = 0;
int numberOfSwaps = 0;

void randArray();				// Prototypes
void bubble(int arr[], int n);
void printArray(int n);
void swap(int *xp, int *yp);

int main() {

	randArray();									// Call randomize function
	
	int n = sizeof(arr1) / sizeof(arr1[0]);			// Set the size of array, randomize, then print data for arr1
	bubble(arr1, n);
	printArray(n);

	n = sizeof(arr2) / sizeof(arr1[0]);				// Set the size of array, randomize, then print data for arr2
	bubble(arr2, n);
	printArray(n);

	n = sizeof(arr3) / sizeof(arr1[0]);				// Set the size of array, randomize, then print data for arr3
	bubble(arr3, n);
	printArray(n);
}

void bubble(int arr[], int n) {

	int i, j;
	bool swapped;									// tried to optimize by leaving inner loop earlier

	for (i = 0; i < n - 1; i++) {	
		swapped = false;
		for (j = 0; j < n - i - 1; j++) {
			numberOfComparisons++;
			if (arr[j] > arr[j + 1]) {				// Swap if needed
				swap(&arr[j], &arr[j + 1]);
				swapped = true;
			}
		}

		if (!swapped)
			break;
	}
}

void swap(int *xp, int *yp) {						// swap called by bubble

	int temp = *xp;
	*xp = *yp;
	*yp = temp;
	numberOfSwaps++;
}

void printArray(int n) {							// Print data on screen
	
	cout << n << " " << numberOfComparisons << " " << numberOfSwaps << "\n\n";
	numberOfComparisons = 0;
	numberOfSwaps = 0;
}

void randArray() {									// Creates 3 random functions of different sizes

	default_random_engine engine(static_cast <unsigned int> (time(0)));
	uniform_int_distribution <unsigned int> randomInt(1, 1000);

	for (unsigned int i = 0; i < 100; ++i) {
		arr1[i] = (randomInt(engine));
	}

	for (unsigned int i = 0; i < 1000; ++i) {
		arr2[i] = (randomInt(engine));
	}

	for (unsigned int i = 0; i < 10000; ++i) {
		arr3[i] = (randomInt(engine));
	}
}