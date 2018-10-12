//
// Created by BrunoSR on 10/3/2018.
//
#include <stdio.h>
#include <iomanip>
#include <iostream>
#include <random>
#include <ctime>
using namespace std;

void randArray(int n);

int main() {

	randArray(10);

}

void randArray(int n) {
	default_random_engine engine(static_cast <unsigned int> (time(0)));
	uniform_int_distribution <unsigned int> randomInt(1, n);
	int arr[n];
	for (unsigned int i = 1; i <= 10; ++i) {
		arr[i] = (randomInt(engine));
		cout << arr[i] << "\n";
	}
}