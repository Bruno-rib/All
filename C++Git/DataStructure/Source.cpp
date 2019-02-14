#include <iterator>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <iomanip>

using namespace std;

void parse_line(const string &str,
	vector<string> &row) {
	istringstream istr(str);
	string tmp;
	while (getline(istr, tmp, ',')) {
		row.push_back(tmp);
	}
}

bool IS_QUIT(string s) {
	if (s == 'X')
		return true;
}


void main () {


	ifstream theFile("customers.csv");
	vector<string> s;
	std::map<char, int> mymap;

	mymap['b'] = 100;
	mymap['a'] = 200;
	mymap['c'] = 300;

	// show content:
	for (std::map<char, int>::iterator it = mymap.begin(); it != mymap.end(); ++it)
		std::cout << it->first << " => " << it->second << '\n';


	parse_line(inputLine, row);
	mymap.insert(std::pair<int, std::string>(400, 'a'));
	
	for (;;) {
		cout << endl << "Enter the customer ID (X to quit): ";
		cin >> s;
		if (IS_QUIT(s))
			break;



	}
	
}