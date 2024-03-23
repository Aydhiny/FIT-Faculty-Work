#include <iostream>
#include <cmath>

using namespace std;

void main() {

	float P = 1.0f;
	float n;

	do {
		cout << "Unesite vrijednsot N: " << endl;
		cin >> n;
	} while (n < 1 || n > 10);

	for (int i = 1; i <= n; i++) {

		P*= pow(i + 1, -1);
	}

	cout << "Proizvod je: " << P << endl;


}