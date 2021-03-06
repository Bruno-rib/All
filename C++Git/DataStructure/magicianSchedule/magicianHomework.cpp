#include "pch.h"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <stdio.h>
using namespace std;

string magician;
string magicianArray[100][30][30] = { "" };
string waitingList[20][20] = { "" };
string holidays[20] = { "" };
int userInput = 0;

void addMagician();
void outputFile(int type);
void removeMagician();
void addSchedule(string x, string y);
void schStatus(int x, string y);
void promptSchStatus();
void cancel();
string inputCust();
string inputHoliday();
int welcome();
int countLines();

int main()
{
	cout << "Magician Schedule Program - Bruno Ribeiro pc7439" << endl;

	/*
	freopen("magic.txt", "w", stdout);
	cout << "Magician Schedule Program - Bruno Ribeiro pc7439" << endl;
	addSchedule("jumanji", "Christmas Day");
	addSchedule("Ulisses", "New Year's Day");
	addSchedule("jorge", "Christmas Day");
	addSchedule("simpleMan", "Christmas Day");
	fclose(stdout);
	*/


	addMagician();
	addSchedule("jumanji", "Christmas Day");
	addSchedule("Ulisses", "New Year's Day");
	addSchedule("jorge", "Christmas Day");
	addSchedule("simpleMan", "Christmas Day");
	


	int w = 0;
	while (w != 6) {
		w = welcome();
		switch (w) {
		case 1:
			addSchedule(inputCust(), inputHoliday());
			break;
		case 2:
			cancel();
			break;
		case 3:
			addMagician();
			break;
		case 4:
			removeMagician();
			break;
		case 5:
			promptSchStatus();
			schStatus(userInput, magician);
			break;
		default:
			w = 6;
		}
	}
}

// asks input from user and rewrites file magician.txt 
void removeMagician() {
	ifstream xFile("magician.txt");
	ofstream temp("temp.txt");
	string dropName;
	string tempStr = "";
	int count = countLines();

	// prompt user for magician and updates the file magician.txt
	cout << "\nWhich magician do you want to remove?\n";
	getline(cin >> ws, dropName);
	cout << count << endl;


	int i = 0;
	int j = 0;
	for (i = 1; i < 11 && magicianArray[i][0][0] != dropName; i++) {} // count where is the magician to be removed
	if (magicianArray[i][0][0] != "") {		// if is empty it did not find it

		// loop that reschedule the quitter schedule
		for (int k = 1; k < 11 && magicianArray[i][k][k] != ""; k++) {
			addSchedule(magicianArray[i][k][k], magicianArray[i][k][0]);
			magicianArray[i][k][k] = tempStr;
			magicianArray[i][k][0] = tempStr;
		}

		// count where the last magician is to replace quitter
		for (j = 1; magicianArray[j][0][0] != ""; j++) {}

		// copies schedule of last magician with him or her
		for (int k = 1; k < 11; k++) {
			magicianArray[i][k][0] = magicianArray[j - 1][k][0];
			magicianArray[i][k][k] = magicianArray[j - 1][k][k];
			magicianArray[j - 1][k][0] = tempStr;
			magicianArray[j - 1][k][k] = tempStr;
		}
		
		// replace magician name and erase copy
		magicianArray[i][0][0] = magicianArray[j - 1][0][0];
		magicianArray[j - 1][0][0] = tempStr;
		cout << dropName << " has been removed" << endl;
	} else 
		cout << "No magician with that name on file" << endl;

	for (i = 1; i < count; i ++)
			temp << magicianArray[i][0][0] << endl;
/*
	// updates schedule
	//cout << magicianArray[4][0][0] << "\tlast magician  " << magicianArray[1][0][0] << "\tFirst magician" << endl;
	cout << magicianArray[4][0][0] << "\tlast magician  " << magicianArray[1][0][0] << "\tFirst magician" << endl;
	*/

	

	
		
		
	temp.close();
	xFile.close();
	remove("magician.txt");
	rename("temp.txt", "magician.txt");
}

string inputCust() {

	// temporary holds input while ckecking array for repetitions and where the info should be saved
	string tempCust = { "" };

	// this block will request an input of the name of the customer to be saved
	cout << "Enter the name of the client: " << endl;

	getline(cin >> ws, tempCust);
	cout << endl;

	return tempCust;
}

string inputHoliday() {

	outputFile(1);
	outputFile(2);

	// temporary holds input while ckecking array for repetitions and where the info should be saved
	string tempDay = { "" };

	// this loop will ask for input and make sure user enters a valid holiday
	int warnFlag = 0;
	while (warnFlag == 0) {
		cout << "Enter the name of the holiday: " << endl;
		getline(cin >> ws, tempDay);
		cout << endl;

		for (int i = 0; i < 20 && warnFlag == 0; i++)
			if (holidays[i] == tempDay)
				warnFlag++;

		if (warnFlag == 0)
			cout << "Please enter a valid holiday" << endl;
	}

	return tempDay;
}

void addSchedule(string x, string y) {
	
	// saves current holiday.txt and magician.txt to arrays
	outputFile(1);
	outputFile(2);

	string tempDay = y;
	string tempCust = x;

	// flag out works like a break out of the loop
	// first indice holds magicians
	// second indice holds the holiday and it is linked to third indice which is the customer that requested
	// nested for loops. Outer loop holds the loop through magicians
	// Inner loop loops through holidays
	int flagOut = 0;
	for (int j = 1; j < 11 && flagOut == 0; j++)
		for (int k = 1; k < 15 && flagOut == 0; k++) {
			if (magicianArray[j][k][0] == tempDay) {
				break;
			} 
			else if (magicianArray[j][0][0] == "")
				flagOut = 2;
			else if (k > 12) {                                 

				for (int l = 1; l < 11 && flagOut == 0; l++) {          
																		// this loop saves the temp into array
					if (magicianArray[j][l][0] == "") {
						
						magicianArray[j][l][0] = tempDay;
						magicianArray[j][l][l] = tempCust;
						flagOut = 1;
						
					}
				}

			}
		}

	// waiting list loop
	if (flagOut == 2) {
		for (int i = 1; i < 15; i++) {
			if (waitingList[i][i] == "") {
				waitingList[i][0] = tempDay;
				waitingList[i][i] = tempCust;
				break;
			}
		}
	}
	schStatus(1, magician);
}

// this program instruct the user to use schStatus program
void promptSchStatus() {
	while (true) {
		cout << "\t1 for full schedule\n\t2 for a magician schedule\n\t3 for a holiday schedule\n";
		cin >> userInput;
		if (userInput == 1) {
			break;
		}
		else if (userInput == 2) {
			cout << "\tWhich magician? " << endl;
			getline(cin >> ws, magician);
			break;
		}
		else if (userInput == 3) {
			cout << "\tWhich holiday? " << endl;
			getline(cin >> ws, magician);
			break;
		}
	}
}

// prints the schedule. 1 for entire schedule and waiting list
// 2 for specific magician
// 3 for specific holiday
void schStatus(int x, string y) {

	outputFile(1);

	if (x == 2) {
		for (int i = 1; i < 11; i++) 
			if (magicianArray[i][0][0] == y) {
				cout << "\nMagician " << y << " schedule is: \n";
				for (int j = 1; j < 11 && magicianArray[i][j][0] != ""; j++)
					cout << "\t" << magicianArray[i][j][0] << endl;
			}
		cout << endl;
	}
	else if (x == 3) {
		cout << "\n Holiday " << y << " have the following magicians working: " << endl;
		for (int i = 1; i < 11; i++) 
			for (int j = 1; j < 11; j++) 
				if (magicianArray[j][i][0] == y) {
					cout << "\t" << magicianArray[j][0][0] << endl;
				}	
		cout << endl;
	}
	else {
		// This loop prints array in tabular format
		cout << "Magician\t\tHoliday\t\tCustomer\t\tmain List" << endl;
		for (int i = 1; i < 11 && magicianArray[i][0][0] != ""; i++) {
			cout << magicianArray[i][0][0] << endl;

			for (int j = 1; j < 11 && magicianArray[i][j][0] != ""; j++) {

				cout << "\t\t\t" << magicianArray[i][j][0] << "\t";
				cout << magicianArray[i][j][j] << endl;
			}
		}
		cout << endl;

		// prints the waiting list
		if (waitingList[1][0] != "")
			cout << "\nWaiting list\t\tHoliday\tCustomer\t\t" << endl;
		for (int i = 1; i < 11 && waitingList[i][0] != ""; i++) {
			cout << "\t\t" << waitingList[i][0] << "\t\t";
			cout << waitingList[i][i] << endl;
		}
	}
}

// request the user to enter holiday and customer to be removed from schedule
void cancel() {
	// temporary holds input while ckecking array for repetitions and where the info should be saved
	string tempCust = { "" };
	string tempDay = { "" };

	cout << "Please enter the name of the customer who wants to cancel reservation: ";
	getline(cin >> ws, tempCust);
	cout << "\nPlease enter the holiday: ";
	getline(cin >> ws, tempDay);


	cout << "\n Holiday " << tempDay << " customer: " << tempCust << endl;
	// 2 outer loops to find holiday
	// after holiday is found then inner loop deletes it
	// by finding the last element and saving on top of it
	int k = 0;
	string temp = "";
	for (int i = 1; i < 11; i++)
		for (int j = 1; j < 11; j++)
			if (magicianArray[j][i][0] == tempDay && magicianArray[j][i][i] == tempCust) {
				for (k = i; k < 11 && magicianArray[j][k][0] != ""; k++) {}
				magicianArray[j][i][0] = magicianArray[j][k - 1][0];
				magicianArray[j][i][i] = magicianArray[j][k - 1][k - 1];
				magicianArray[j][k - 1][0] = temp;
				magicianArray[j][k - 1][k - 1] = temp;
			}
	cout << endl;
}

// prompt choices from user and calls appropriate function
int welcome() {
	int x = 0;
	cout << "\n\nWhat would you like to do?" << "\n" << "1 for schedule"
		<< "\n" << "2 to cancel a reservation" << "\n" << "3 for signup"
		<< "\n" << "4 for dropOut" << "\n" << "5 for status" << "\n" << "6 to quit"
		<< "\n" << endl;

	cin >> x;

	return x;
}

// saves current info from file to array
void outputFile(int type) {
	int i = 1;

	string filename;
	switch (type) {
	case 1: {
		filename = "magician.txt";
		break;
	}
	case 2: {
		filename = "Holidays.txt";
		break;
	}
	}

	ifstream xFile(filename.c_str());

	while (getline(xFile, magician)) {
		if (type == 1) {
			magicianArray[i][0][0] = magician;
			i++;
		}
		else if (type == 2) {
			holidays[i] = magician;
			i++;
		}

	}

	xFile.close();
}

// asks input from user and rewrites file magician.txt 
void addMagician() {
	ofstream xFile("magician.txt", ios_base::app);
	string line = { "" };
	int count = 0;

	if (xFile.is_open()) {
		cout << "\nEnter the name of the magician to add: " << endl;
		getline(cin >> ws, magician);
		
		if (countLines() < 10) {
			xFile << magician << endl;
			cout << magician << " has been added as a magician" << endl;
		}
		else
			cout << "Magician list is full" << endl;
	}
	else {
		cout << "file is not open" << endl;
	}

	xFile.close();
}

// program addMagician
int countLines() {
	int count = 0;
	string line;

	ifstream xFile("magician.txt");
	while (getline(xFile, line))
		count++;
	
	xFile.close();
	return count;
}
