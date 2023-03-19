#include <iostream>
#include <cmath>


using namespace std;


void main() {

	int rezultat = 1;
	int n;

	do {
		cout << "Unesite vrijednsot N: " << endl;
		cin >> n;
	} while (n < 0);

	for (int i = 1; i <= n; i+= 2) {
		if (n % 5 == 0) {

			n = (pow(i * n, 1/ n));

		}

	}

	cout << "Geometrijska sredina svih neparnih brojeva je: " << n << endl;



}