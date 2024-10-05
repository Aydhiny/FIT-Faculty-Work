#include <iostream>
#include <cmath>

using namespace std;


int main() {

	int n;
	float s = 0.0f;

	do {
		cout << "Unesite vrijednost N " << endl;
		cin >> n;

	} while (n < 1 || n > 100);

	for (int i = 1; i <= n; i++) {

		s += pow(i, 2) / sqrt(i);
	}

	cout << "Suma je: " << s << endl;


}