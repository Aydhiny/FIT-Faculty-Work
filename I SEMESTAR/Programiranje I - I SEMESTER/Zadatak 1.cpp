#include <iostream>

using namespace std;

int main() {

	double y;
	double x;
	string karakter;
	cout << "Unesite x: " << endl;
	cin >> x;

	cout << "Unesite karakter: " << endl;
	cout << "sin - sinus " << endl;
	cout << "cos - cosinus " << endl;
	cin >> karakter;


	while (karakter != "sin" && karakter != "cos") {
		cout << "Unesite normalnu vrijednost konjino!" << endl;
		cin >> karakter;
	}
	if (karakter == "sin") {

		y = x / (sin (x / x) + x);
		cout << "Rezultat je: " << y << endl;
	}
	else if (karakter == "cos") {

		y = x / (cos (x / x) + x);
		cout << "Rezultat je: " << y << endl;
	}

	return 0;
}