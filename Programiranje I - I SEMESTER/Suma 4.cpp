#include <iostream>
#include <math.h>

using namespace std;


void main() {

	int n;

	do {
		cout << "Unesite vrijednost N: " << endl;
		cin >> n;
	} while (n <= 0);

	int s = 0.0;
	for (int i = n; i <= 2* n; i++) {

		s += pow(2, abs(i - 2));
	}

	cout << "Suma je: " << s << endl;
	cin >> s;

}