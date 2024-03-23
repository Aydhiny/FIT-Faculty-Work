#include <iostream>

using namespace std;

int main() {

	double x;
	char odabir;

	cout << "Unesite vrijednost x: " << endl;
	cin >> x;

	cout << "Unesite karakter: " << endl;
	cin >> odabir;

	switch (odabir) {
	case ('s'): 
		x = 1 + x / sin(x / x) + x;
		cout << "Rezultat vaseg unosa je: " << x << endl;
		break;
	case ('c'):
		x = 1 + x / cos(x / x) + x;
		cout << "Rezultat vaseg unosa je: " << x << endl;
		break;
	default: cout << "Unesite pravu vrijednost!" << endl;
		break;
	}


	return 0;
}