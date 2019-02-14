
/*********************************************************************************
 * Assignment #: 2
 * Programmer Name:
 * Date: December 1, 2018
 *
 * Implement an interactive program to read the CSV file of Customer data. Load
 * the Customer ID and Monthly MonthlyCharges from the CSV file into the Map and
 * provide a sentinel loop to interact with the User.
 *
 * Prompt the user for the Range of 2 Key values (Customer Ids). Print the records
 * that fall within the range of these 2 keys inclusive.
 *
 *
 *********************************************************************************/
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

    // customer ids for range
    string customer_id_one, customer_id_two;

    // Set output formatting
    cout.setf(ios::fixed | ios::showpoint);
    cout.precision(2);

    // Iterator to find the data
    map<string, double>::iterator lowItr, upItr, itr;

    // Interact with user
    do
    {
        cout << "Enter the lower and upper values of the range (X to quit): " << endl;

        // read first id
        cin >> customer_id_one;

        // if not x, search
        if(customer_id_one != "X" && customer_id_one != "x")
        {
            // read second id
            cin >>  customer_id_two;


            // find lower and upper bounds
            lowItr = customers.lower_bound (customer_id_one);
            upItr = customers.upper_bound(customer_id_two);

            cout << "The customers in this range are: " << endl;

            // If found, display charges
            if(lowItr != customers.end() && upItr != customers.end())
            {
                for(itr = lowItr; itr != upItr; itr++)
                {
                    cout << "\t" << itr->first << ": $" << itr->second << endl;
                }
            }
            else // not found display message
            {
                cout << "One of the Customer Id you entered doesn't exist." << endl;
            }
        }
        else
        {
            cout << "Exiting....." << endl;
        }

    }while(customer_id_one != "X" && customer_id_one != "x");

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
            ss.str(row[18]); // 19TH VALUE
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
