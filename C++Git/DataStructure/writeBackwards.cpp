
#include <stdio.h>
#include <iostream>
#include <string>

using namespace std;

//prototype
void writeArrayNthBackward(string s, int first, int last, int n);
void writeOrganized();


// test driver
int main()
{
  writeOrganized();
}

// print an array backwards, where 'first' is the first index
// of the array, and 'last' is the last index 
void writeArrayNthBackward(string s, int first, int last, int n) {

	if (last < first) {
	    cout << endl;
	}
	else {
		cout << s[last];
		writeArrayNthBackward(s, first, last - n, n);
	}
}

// print results in a box
void writeOrganized() {

	cout << "Input String\tN\tOutput\n\n";

	int n = 2;
	string s = "abc123";
	cout << s << "\t\t" << n << "\t";
	writeArrayNthBackward(s, 0, s.length(), n);

	int n1 = 1;
	string s1 = "hello";
	cout << s1 << "\t\t" << n1 << "\t";
	writeArrayNthBackward(s1, 0, s1.length(), n1);

	int n2 = 3;
	string s2 = "hello";
	cout << s2 << "\t\t" << n2 << "\t";
	writeArrayNthBackward(s2, 0, s2.length(), n2);

	int n3 = 2;
	string s3 = "c1c1c1";
	cout << s3 << "\t\t" << n3 << "\t";
	writeArrayNthBackward(s3, 0, s3.length(), n3);
}
