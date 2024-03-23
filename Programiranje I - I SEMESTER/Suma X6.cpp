#include <iostream>

using namespace std;

void main() {

	float s = 0.00f;
	float n;


	do {
		cout << "Unesite vrijednost: " << endl;
		cin >> n;
	} while (n > 5);

	for (int i = 1; i <= n; i++) {
		for (int j = 5; j <= 10; j++)

			s += pow(i, 2) * j - pow(j, 2) * i;
	}

	cout << "Suma je BEGI: " << s << endl;
}