#include <iostream>
#include <cmath>
#include < stdlib.h >

using namespace std;

int main() {

	int izbor;
	float x;
	cout << "Unesite vrijednost: " << endl;
	cin >> x;

	do {
		cout << "Unesite funkciju: " << endl;
		cout << "1 - sin " << endl;
		cout << "2 - cos " << endl;
		cout << "3 - EXIT" << endl;
		cin >> izbor;

		if (izbor != '1', '2', '3') {

			cout << "ERROR niste unijeli broj" << endl;
			return 0;
		}

		switch (izbor) {
		case(1): x = 1 / sin(x) + x;
			cout << "Rezultat je: " << x << endl;
			break;
		case(2): x = 1 / cos(x) + x;
			cout << "Rezultat je: " << x << endl;
			break;
		case(3): 
			cout << "You have exited the program" << endl;
			return 0;
			break;
		default:
			cout << "ERROR Unijeli ste pogresnu vrijednost" << endl;
		}

	}

	while (izbor != '1' && izbor != '2');

	return 0;
}