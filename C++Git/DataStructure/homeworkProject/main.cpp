/*
Bruno Silva Ribeiro
Lab #2 - Stack or No Stack?

this lab requires to add values to be checked in correct format
inside the file homework.txt
*/
#include <iostream>
#include <fstream>
#include <string>
#include <stack>
#include <queue>
using namespace std;

/*
Reads a file called homework.txt in which should be set as a specific format according to example
decides if the blocks of data are stack format or not
prints to the console "stack" or "not stack" to each block of data
*/
void readingFile();

int main() {
    readingFile();
}

void readingFile() {
    stack <int> myStack;				// declares a stack to save info
    queue <int> myQueue;                // declares a queue to save info

    int first;							// first column of data
    int second;							// second column of data
    ifstream myFile("homework.txt");	// opening the file
    if (myFile.is_open()) {				// check if file is open before startint the process

        while (myFile >> first) {								// reads the number of lines to evaluate
            for (int i = first; i > 0; i--) {					// uses the info above to run the loop
                myFile >> first >> second;						// reads each line and separates

                if (first == 1)									// according to assignment 1 means push into stack
                    myStack.push(second);						// pushing second reading from each line into stack
                else if (first == 2 && second == myStack.top())	// only poping the stack if the last info in the stack matches second
                    myStack.pop();

                if (first == 1)                                 // same as above but for queue instead
                    myQueue.push(second);
                else if (first == 2 && second == myQueue.front())
                    myQueue.pop();

            }
            if (myStack.empty())								// evaluates the stack and queue and prints result
                cout << "stack\n";
            else if (myQueue.empty())
                cout << "queue\n";

            while (!myStack.empty())							// make sure stack and queue are empty for the next while loop
                myStack.pop();
            while (!myQueue.empty())
                myQueue.pop();
        }
        myFile.close();					// Done so we close the file
    }

    else cout << "Unable to open file";	// if check of fileOpen was false it skips down here
}



