#include <stdio.h>
#include <iostream>
#include <ctime>

using namespace std;

#define HEAPSIZE	10
#define MAXNUM		100

typedef enum {
	MINHEAP,
	MAXHEAP
} heapType;

int getLeftChildIndex(int nodeIndex) {
	return (2 * nodeIndex) + 1;
}

int getRightChildIndex(int nodeIndex) {
	return (2 * nodeIndex) + 2;
}

int getParentIndex(int nodeIndex) {
	return (nodeIndex - 1) / 2;
}

bool isLeaf(const int nodeIndex, int itemCount) {
	return (getLeftChildIndex(nodeIndex) >= itemCount);
}

void printIt(int items[], int itemCount) {
	cout << "\t";
	for (int i = 0; i < itemCount; i++) {
		cout << items[i] << " ";
	}
	cout << endl;
}

void heapify(const int subTreeNodeIndex, int items[], int itemCount, heapType hType) {
	
	// subTreeNodeIndex = 0 to 4
	// htype = MAXHEAP
	// items = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
	// itemCount = 10

	int temp = 0;
	int leafy;
	int rooty = getParentIndex(subTreeNodeIndex);
	int lefty = getLeftChildIndex(subTreeNodeIndex);
	int righty = getRightChildIndex(subTreeNodeIndex);

	if (hType == MAXHEAP) {

		cout << "\t index is " << subTreeNodeIndex << "\t left child " << lefty << "\t right child " << righty << "\t root is " << rooty << endl;

		if (righty < itemCount && lefty < righty) {

			leafy = righty;

		}
		else {

			leafy = lefty;

		}

		if (items[rooty] < items[leafy]) {
			temp = items[rooty];
			items[rooty] = items[leafy];
			items[leafy] = temp;

			if (items[rooty] > 0)
				heapify(subTreeNodeIndex - 1, items, itemCount, hType);
		}



	}



}


void heapifyArray(int items[], int itemCount, heapType hType) {
	for (int index = itemCount / 2; index >= 0; index--) {
		heapify(index, items, itemCount, hType);
	}
	cout << endl;
}

int main() {
	int items[HEAPSIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	/*
	//srand(time(0));

	//for (int i = 0; i < sizeof(items) / sizeof(int); i++)
		//items[i] = rand() % MAXNUM;

	cout << sizeof(items) << "\t sizeof(int) is \t" << sizeof(int) << "\t division is \t" << sizeof(items) / sizeof(int) << endl;

	cout << "before heapify: " << endl;
	printIt(items, HEAPSIZE);
	*/
	heapifyArray(items, sizeof(items) / sizeof(int), MAXHEAP);
	
	cout << "after max-heapify:" << endl;
	printIt(items, HEAPSIZE);

	heapifyArray(items, sizeof(items) / sizeof(int), MINHEAP);

	cout << "after min-heapify:" << endl;
	printIt(items, HEAPSIZE);
	
}