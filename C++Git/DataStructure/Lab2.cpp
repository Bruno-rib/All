#include "pch.h"
#include <iostream>
using namespace std;

// necessary for arrays operations
int myList[20] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 };
int myLow[20] = { 0 };
int myHigh[20] = { 0 };
int split = 0;
int delItem = 0;

void splitLists(int arr[], int x, int arr1[], int arr2[]);
void printLists(int arr[], int x, int arr1[], int arr2[]);
void deleteItem(int arr[], int x);
int welcome();

// overloaded functions for string operations
string myStr = "The only source of knowledge is experience";
char delStrItem;
char splitStr;
char myString[50] = { "" };
char myLowStr[50] = { "" };
char myHighStr[50] = { "" };
void stringToArray(string str, char arr[]);
void splitString(char arr[], char x, char arr1[], char arr2[]);
void deleteStr(char arr[], char x);
void printString(char arr[], char x, char arr1[], char arr2[]);

int main()
{
	stringToArray(myStr, myString);
	cout << "Assignment 2 by Bruno Ribeiro - pc7439\n\n";

	int w = 0;
	while (w != 7) {
		w = welcome();
		switch (w) {
		case 1:
			printLists(myList, split, myLow, myHigh);
			break;
		case 2:
			cout << "\n\nWhat number would you like to split?\n";
			cin >> split;
			splitLists(myList, split, myLow, myHigh);
			break;
		case 3:
			cout << "\n\nWhat number would you like to delete?\n";
			cin >> delItem;
			deleteItem(myList, delItem);
			break;
		case 4:
			cout << "\n\nAt what letter would you like to split the string?\n";
			cin >> splitStr;
			splitString(myString, splitStr, myLowStr, myHighStr);
			break;
		case 5:
			cout << "\n\nWhat letter would you like to delete?\n";
			cin >> delStrItem;
			deleteStr(myString, delStrItem);
			break;			
		case 6:			
			printString(myString, splitStr, myLowStr, myHighStr);
			break;
		default:
			w = 7;
		}
	}
}

// make the input string into an array
void stringToArray(string str, char arr[]) {
	for (int i = 0; i < 50 && str[i] != 0; i++)
		arr[i] = str[i];
}

// interactive prompt to use this program
int welcome() {
	int x = 0;
	cout << "\n\nWhat would you like to do?" << "\n1 to print all array lists" 
		<< "\n2 to split the array list" << "\n3 to delete an item of the array list"
		<< "\n4 to split an string" << "\n5 delete a letter from a string" 
		<< "\n6 to print all strings" << "\n7 to quit\n" << endl;

	cin >> x;

	return x;
}

// delete item on mylist on position x
void deleteItem(int arr[], int x) {
	int temp = 0;
	int max = 19;

	for (int i = 0; i < 20; i++) {
		if (arr[i] == x) {
			temp = arr[max];
			arr[i] = temp;
			arr[max] = 0;
			max--;
		}
	}
	if (split != 0) 
		splitLists(myList, split, myLow, myHigh);
}

// overloaded function for strings with same functionality as the function above
void deleteStr(char arr[], char x) {

	for (int i = 0; i < 50; i++) {
		if (arr[i] == x) {
			arr[i] = arr[50];
		}
	}
	if (split != 0)
		splitLists(myList, split, myLow, myHigh);
}

// split myList into 2 smaller arrays, at position x
void splitLists(int arr[], int x, int arr1[], int arr2[]) {

	// reset lists so you can split twice in the same program
	for (int i = 0; i < 20; i++) {
		arr1[i] = 0;
		arr2[i] = 0;
	}

	// split the list into high and low
	for (int i = 0; i < 20; i++) {
		if (i <= x) {
			arr1[i] = arr[i];
		}
		else {
			arr2[i] = arr[i];
		}
	}	
}

// overloaded function with same functionality as the one above
void splitString(char arr[], char x, char arr1[], char arr2[]) {

	int j = 0;

	// reset strings so you can split twice in the same program
	for (int i = 0; i < 50; i++) {
		arr1[i] = '0';
		arr2[i] = '0';
	}

		// find index
	for (int i = 0; i < 50; i++) 
		if (arr[i] == x)
			j = i;


		// split string
	for (int i = 0; i < 50; i++) {
		if (i <= j) {
			arr1[i] = arr[i];
		}
		else {
			arr2[i] = arr[i];
		}
	}
}

// print all 3 lists
void printLists(int arr[], int x, int arr1[], int arr2[]) {
	cout << "\n\nSplit Index: " << x << endl;
	cout << "Full List: { ";
	for (int i = 0; i < 20; i++) {
		if (arr[i] != 0)
			cout << arr[i] << " ";
	}
	cout << "}" << endl;
	cout << "Lower List: { ";
	for (int i = 0; i < 20; i++) {
		if (arr1[i] != 0)
			cout << arr1[i] << " ";
	}
	cout << "}" << endl;
	cout << "Higher List: { ";
	for (int i = 0; i < 20; i++) {
		if (arr2[i] != 0) {
			cout << arr2[i] << " ";
		}
	}
	cout << "}" << endl;
}

// overloaded function with same functionality of the one above
void printString(char arr[], char x, char arr1[], char arr2[]) {

	cout << "\n\nSplit Letter: " << x << endl;
	cout << "Full String: ";
	for (int i = 0; i < 50; i++) {
		if (arr[i] != 0)
			cout << arr[i];
	}
	cout << endl;
	cout << "Lower subString: ";
	for (int i = 0; i < 50; i++) {
		if (arr1[i] != 0 && arr1[i] != '0')
			cout << arr1[i];
	}
	cout << endl;
	cout << "Higher subString: ";
	for (int i = 0; i < 50; i++) {
		if (arr2[i] != 0 && arr2[i] != '0') {
			cout << arr2[i];
		}
	}
	cout << endl;
}


