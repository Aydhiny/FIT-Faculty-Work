#include <iostream>
using namespace std;




/*Poštujući sve faze programiranja napisati program koji 
omogućava unos prirodnog broja n preko tastature te izračunava sumu:*/

int rezultat() {

	float rezultat = 0;
	int n;
	cout << "Unesite vrijednost n: " << endl;
	cin >> n;

	for (int i = 1; i <= n; i++) {

		rezultat += 1 / pow ((2 * n + 1), 2);
	}
	return rezultat;
}