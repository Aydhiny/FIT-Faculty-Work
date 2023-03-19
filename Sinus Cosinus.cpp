#include <iostream>
#include <cmath>


using namespace std;

int main() {


	float rezultat = 1.0;
	float x;
	char unos;


	cout << "Unesite vrijednost x: " << endl;
	cin >> x;

	do {

		cout << "Unesite s za sinus ili c za cos operaciju: " << endl;
		cin >> unos;
	} while (unos != 's' && unos != 'c');


	if (unos == 's') {

		for (int i = 1; i <= x; i++) {

			rezultat+= i / (sin(x / i) + x);
		}

	}
	else {

		for (int i = 1; i <= x; i++) {

	
			rezultat += i / (cos(x / i) + x);
		}

	}
		cout << "Rezultat je: " << rezultat << endl;

		return 0;


}
