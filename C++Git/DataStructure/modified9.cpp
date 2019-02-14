#include <sstream>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <iomanip>

using namespace std;

// Constant for the input file name.
const string FILE_NAME = "customers.csv";

//--------------------------------------------------------------------------------
// Function to load the Map with the Customer ID and Monthly Charges of the
// customer from the given file.
//--------------------------------------------------------------------------------
void load_data(map<string, double> & customers, string fileName);

//--------------------------------------------------------------------------------
// Function to Parse the csv Line record into a Vector and return it.
//--------------------------------------------------------------------------------
void parse_line(const string &, vector<string> &);

//--------------------------------------------------------------------------------
// Main Method - entry point of the program.
//--------------------------------------------------------------------------------
int main() {

    // Map of data, with customer id and monthly charges
    map<string, double> customers;

    // Load the data into the map
    load_data(customers, FILE_NAME);

    // customer id
    string customer_id;

    // Set output formatting
    cout.setf(ios::fixed | ios::showpoint);
    cout.precision(2);

    // Iterator to find the data
    map<string, double>::iterator itr;

    // Interact with user
    do
    {
        cout << "Enter the customer ID (X to quit): ";
        cin >> customer_id;

        // if not x, search
        if(customer_id != "X" && customer_id != "x")
        {
            itr = customers.find(customer_id);

            // If found, display charges
            if(itr != customers.end())
            {
                cout << "The customer's monthly charges are: $" << itr->second << endl;
            }
            else // not found display message
            {
                cout << "That customer does not exist in the file." << endl;
            }
        }
        else
        {
            cout << "Exiting....." << endl;
        }

    }while(customer_id != "X" && customer_id != "x");

    return 0;
}
//--------------------------------------------------------------------------------
// Function to load the Map with the Customer ID and Monthly Charges of the
// customer from the given file.
//--------------------------------------------------------------------------------
void load_data(map<string, double> & customers, string fileName) {

    // Open input stream
    ifstream inFile(fileName.c_str(), ios::in);

    // if not open, exit and notify
    if(inFile.fail())
    {
        cout << "ERROR: Opening file - " << fileName << endl;
        exit(0);
    }

    // Read the file line by line, parse the line into a vector, and then get the
    // 0th and 20th item from the vector to store into map as per the given instructions.
    string line;
    double charges;

    // while not end of file
    while(!inFile.eof())
    {
        // read the line
        getline(inFile, line, '\n');

        // successfully read
        if(inFile)
        {
            // Parse the csv string
            vector<string> row;

            // Call function to parse
            parse_line(line, row);

            // Parse the charges using string stream.
            stringstream ss;
            ss.str(row[5]); // 19TH VALUE
            ss >> charges;

            // Store into map
            customers.insert(pair<string, double>(row[0], charges));
        }
    }

    // close input file
    inFile.close();
}

//--------------------------------------------------------------------------------
// Function to Parse the csv Line record into a Vector and return it.
//--------------------------------------------------------------------------------
void parse_line(const string & str, vector<string> & row) {
    istringstream istr(str);
    string tmp;

    while (getline(istr, tmp, ',')) {
        row.push_back(tmp);
    }
}
