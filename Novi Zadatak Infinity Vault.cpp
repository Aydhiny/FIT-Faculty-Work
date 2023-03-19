#include <iostream>

using namespace std;
float unosx();
char odabir();
float proracun();

float unosx() {

	float x;
	cout << "Unesite vrijednost x: " << endl;
	cin >> x;

	return x;

}

char odabir() {

		char odabir1;
	do {
		cout << "Unesite 's' za sin i 'c' za cos: " << endl;
		cin >> odabir1;
	} while (odabir1 != 's' && odabir1 != 'c');
	cout << "Unijeli ste pogresnu vrijednost!" << endl;


	return odabir1;
}


float proracun(float x, char odabir1) {


	float rezultat = 0;

	if (odabir1 == 's') {
		for (int i = 1; i <= x; i++) {

			rezultat = i / sin(x / i) + x;
		}
	}

	else {
			for (int i = 1; i <= x; i++) {

				rezultat = i / cos(x / i) + x;
			}

	}
	return rezultat;

}


int main() {

	float x = unosx();
	char odabir1 = odabir();
	cout << "Proracun ovog broja je: " << proracun(x, odabir1) << endl;


}