#include <iostream>
#include <cmath>


using namespace std;

void main() {

	float s = 0.0;
	float n;

	do {
		cout << "Unesite vrijednost N " << endl;
		cin >> n;
	} while (n < -5 || n == 0);

	for (int i = -5; i <= n; i++) {

		s += abs(float(i) / n);

	}

		cout << "Suma je: " << s << endl;

}