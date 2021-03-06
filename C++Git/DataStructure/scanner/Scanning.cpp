/*
	Bruno S Ribeiro - pc7439
	Scanning program

	This program was written to get the job done through brute force and not elegance 
		Readability might be slightly compromised :)

	This program will read a txt file with a c++ functional program.
		Then it will separate everything by spaces and new lines and saving 
		each item in an array. Then it will separate (and print) each item
		to the following categories:
		-keyword
		-identifier
		-special char
		-digits
		-strings
	Also the program will count repetition, show the total of each category, and print 
		the number of spaces and newlines found

	The program in the file looks like the following:

#include <iostream>
using namespace std ;

int main() {

  int fNumber = 2 + 5 ;
  int lNumber = 4 * 3 ;
  int sum = fNumber + lNumber ;

  cout << "Hello_World!" << "_did_you_know_that:" << endl ;
  cout << "\t" << fNumber << "+" << lNumber ;
  cout << "=" << sum << endl ;

  return 0 ;
}

*/

#include "pch.h"
#include <string>
#include <fstream>
#include <iostream>
#include <sstream>
using namespace std;

int spaces = 0;
int newLines = 0;
string input;
string inputArray[200][100] = { "" };
int outArray[200][100] = { 0 };
void readFile();
void sepToken();
void print();

int main()
{
	readFile();
	sepToken();
	print();
}

// This program will output the types and count of each in tabular format
void print() {

	cout << "  *\tkeyword:  \trepetition:\n";
	cout << "\t" << "int" << "\t\t" << outArray[0][0] << endl;
	cout << "\t" << "using" << "\t\t" << outArray[0][1] << endl;
	cout << "\t" << "return" << "\t\t" << outArray[0][2] << endl;
	cout << "\t" << "#include" << "\t" << outArray[0][3] << endl;
	cout << "\t" << "cout" << "\t\t" << outArray[0][4] << endl;
	cout << "\t" << "endl" << "\t\t" << outArray[0][5] << endl;
	cout << "  Total keywords:" << "\t" << 
		outArray[0][0] + outArray[0][1] + outArray[0][2] + 
		outArray[0][3] + outArray[0][4] + outArray[0][5] << endl;
	
	cout << "\n\n  *\tidentifier:  \trepetition:\n";
	cout << "\t" << "main()" << "\t\t" << outArray[1][0] << endl;
	cout << "\t" << "namespace" << "\t" << outArray[1][1] << endl;
	cout << "\t" << "std" << "\t\t" << outArray[1][2] << endl;
	cout << "\t" << "iostream" << "\t" << outArray[1][3] << endl;
	cout << "\t" << "fNumber" << "\t\t" << outArray[1][4] << endl;
	cout << "\t" << "lNumber" << "\t\t" << outArray[1][5] << endl;
	cout << "\t" << "sum" << "\t\t" << outArray[1][6] << endl;
	cout << "  Total identifiers:" << "\t" <<
		outArray[1][0] + outArray[1][1] + outArray[1][2] +
		outArray[1][3] + outArray[1][4] + outArray[1][5] + outArray[1][6] << endl;

	cout << "\n\n  *\tspecial char:  \trepetition:\n";
	cout << "\t" << "+" << "\t\t" << outArray[2][0] << endl;
	cout << "\t" << "=" << "\t\t" << outArray[2][1] << endl;
	cout << "\t" << ";" << "\t\t" << outArray[2][2] << endl;
	cout << "\t" << "{" << "\t\t" << outArray[2][3] << endl;
	cout << "\t" << "}" << "\t\t" << outArray[2][4] << endl;
	cout << "\t" << "*" << "\t\t" << outArray[2][5] << endl;
	cout << "\t" << "<<" << "\t\t" << outArray[2][6] << endl;
	cout << "  Total identifiers:" << "\t" <<
		outArray[2][0] + outArray[2][1] + outArray[2][2] +
		outArray[2][3] + outArray[2][4] + outArray[2][5] + outArray[2][6] << endl;

	cout << "\n\n  *\tdigits:  \trepetition:\n";
	cout << "\t" << "0" << "\t\t" << outArray[3][0] << endl;
	cout << "\t" << "2" << "\t\t" << outArray[3][1] << endl;
	cout << "\t" << "3" << "\t\t" << outArray[3][2] << endl;
	cout << "\t" << "4" << "\t\t" << outArray[3][3] << endl;
	cout << "\t" << "5" << "\t\t" << outArray[3][4] << endl;
	cout << "  Total identifiers:" << "\t" <<
		outArray[3][0] + outArray[3][1] + outArray[3][2] +
		outArray[3][3] + outArray[3][4] << endl;

	cout << "\n\n  *\tstrings:  \trepetition:\n";
	cout << "\"Hello_World!\"" << "\t\t" << outArray[4][0] << endl;
	cout << "\"_did_you_know_that:\"" << "\t" << outArray[4][1] << endl;
	cout << "\t" << "\"\\t\"" << "\t\t" << outArray[4][2] << endl;
	cout << "\t" << "\"+\"" << "\t\t" << outArray[4][3] << endl;
	cout << "\t" << "\"=\"" << "\t\t" << outArray[4][4] << endl;	
	cout << "  Total identifiers:" << "\t" <<
		outArray[4][0] + outArray[4][1] + outArray[4][2] +
		outArray[4][3] + outArray[4][4] << endl;

	cout << "\n\n  Bonus Fun Facts: " << endl;
	cout << "\n  Total items: " << spaces - newLines + 1 << endl;
	cout << "  Total new lines: " << newLines - 1 << endl;
}

// check each word and save its count on outArray[j][k]
void sepToken() {

	for (int j = 0; j < 200; j++) {
		for (int k = 0; k < 100; k++)
			if (inputArray[j][k] != "") {		

				if (inputArray[j][k] == "int")	// check for keyword
					outArray[0][0] ++;
				else if (inputArray[j][k] == "using")
					outArray[0][1] ++;
				else if (inputArray[j][k] == "return")
					outArray[0][2] ++;
				else if (inputArray[j][k] == "#include")
					outArray[0][3] ++;
				else if (inputArray[j][k] == "cout")
					outArray[0][4] ++;
				else if (inputArray[j][k] == "endl")
					outArray[0][5] ++;

				else if (inputArray[j][k] == "main()")	// check for identifier
					outArray[1][0] ++;
				else if (inputArray[j][k] == "namespace")
					outArray[1][1] ++;
				else if (inputArray[j][k] == "std")
					outArray[1][2] ++;
				else if (inputArray[j][k] == "<iostream>")
					outArray[1][3] ++;
				else if (inputArray[j][k] == "fNumber")
					outArray[1][4] ++;
				else if (inputArray[j][k] == "lNumber")
					outArray[1][5] ++;
				else if (inputArray[j][k] == "sum")
					outArray[1][6] ++;

				else if (inputArray[j][k] == "+")	// check for special characters
					outArray[2][0] ++;
				else if (inputArray[j][k] == "=")
					outArray[2][1] ++;
				else if (inputArray[j][k] == ";")
					outArray[2][2] ++;
				else if (inputArray[j][k] == "{")
					outArray[2][3] ++;
				else if (inputArray[j][k] == "}")
					outArray[2][4] ++;
				else if (inputArray[j][k] == "*")
					outArray[2][5] ++;
				else if (inputArray[j][k] == "<<")
					outArray[2][6] ++;

				else if (inputArray[j][k] == "0")	// check for digits
					outArray[3][0] ++;
				else if (inputArray[j][k] == "2")
					outArray[3][1] ++;
				else if (inputArray[j][k] == "3")
					outArray[3][2] ++;
				else if (inputArray[j][k] == "4")
					outArray[3][3] ++;
				else if (inputArray[j][k] == "5")
					outArray[3][4] ++;

				else if (inputArray[j][k] == "\"Hello_World!\"")	// check for strings
					outArray[4][0] ++;
				else if (inputArray[j][k] == "\"_did_you_know_that:\"")	
					outArray[4][1] ++;
				else if (inputArray[j][k] == "\"\\t\"")
					outArray[4][2] ++;
				else if (inputArray[j][k] == "\"+\"")
					outArray[4][3] ++;
				else if (inputArray[j][k] == "\"=\"")
					outArray[4][4] ++;
			}	
	}
}

// reads entire file and places in inputArray[i][n]
// also prints file to the screen from the array 
void readFile() {
	int i = 0;            // lines of file (row)
	ifstream xFile("scan.txt");

	if (xFile.is_open()) {
		while (getline(xFile, input)) {    // get line from file

			istringstream ss(input);
			string token = "";
			int n = 0;         // each word of line (column)

			while (getline(ss, token, ' ')) {	// separate line by spaces
				inputArray[i][n] = token;
				cout << inputArray[i][n] << ' ';
				n++;
				spaces++;
			}
			cout << endl;
			i++;
			newLines++;
		}
	} else
		cout << "file is not open" << endl;

	xFile.close();
}