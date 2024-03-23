#include <iostream>
using namespace std;

int main()
{

	char ch;

	do {
		char a;
		cout << "Enter a character:";
		cin >> a;
		a = a - 32;
		cout << "Converted character to UPPERCASE:";
		cout << a << endl;

		cout << "Press 'n' to exit, or anything else to continue" << endl;
		cin >> ch;
	}

	while (ch != 'n');
	
	return 0;
}