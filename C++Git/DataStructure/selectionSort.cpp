#include <iostream>
#include <ctime>
#include <random>
using namespace std;

int minIndex(int a[], int i, int j);
void selectSort(int a[], int n, int index);
void randArray(int a[]);
void printArray(int a[]);

int arr[20];     // change size of the array by changing brackets and next line 'n'
int n = 20;

int main() {
	
	randArray(arr);

	cout << "before sort\n" << endl;
	printArray(arr);

	selectSort(arr, n, 0);

	cout << "\nafter sort\n" << endl;
	printArray(arr);
}

void printArray(int a[]) {
	for (int i = 0; i < (n / 10); i++) {
		for (int j = 0; j < 10; j++) {
			cout << a[i * 10 + j] << "\t";
		}
		cout << "\n" << endl;
	}
}


void randArray(int a[]) {				// generates random array					

	default_random_engine engine(static_cast <unsigned int> (time(0)));
	uniform_int_distribution <unsigned int> randomInt(1, 1000);

	for (unsigned int i = 0; i < n; i++) {
		arr[i] = (randomInt(engine));
	}
}

void selectSort(int a[], int n, int index) {		//recursive selection sort
	if (index == n)
		return;

	int k = minIndex(a, index, n - 1);

	if (k != index)
		swap(a[k], a[index]);

	selectSort(a, n, index + 1);
}

int minIndex(int a[], int i, int j) {				// find minimum and return it
	if (i == j)
		return i;

	int k = minIndex(a, i + 1, j);

	return (a[i] < a[k]) ? i : k;
}

