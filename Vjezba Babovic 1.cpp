#include <iostream>

using namespace std;
float unosx();
char odabirFunkcije();
float Rezultat();

float unosx() {

	float x;
	cout << "Unesite vrijednost x: " << endl;
	cin >> x;

	return x;
}

char odabirFunkcije() {

	char Odabir;

	do {
		cout << "Unesite znak 's' za sinus, ili 'c' sa cosinus" << endl;
		cin >> Odabir;

		if (Odabir != 's' && Odabir != 'c') {
			cout << "Unijeli ste pogresan znak!" << endl;
		}
	} while (Odabir != 's' && Odabir != 'c');

	return Odabir;

}

float Rezultat(float x, char Odabir) {

	float rezultat = 1.0;
	if (Odabir == 's') {

		for (int i = 1; i <= x; i++)

			rezultat = 1 + i / sin(x / i) + x;

	}

	else {

		for (int i = 1; i <= x; i++) 

			rezultat = 1 + i / cos(x / i) + x;

	}
	return rezultat;
}

int main() {


	float x = unosx();
	char Odabir = odabirFunkcije();
	cout << "Vas rezultat je: " << Rezultat(x, Odabir) << endl;


	return 0;
}