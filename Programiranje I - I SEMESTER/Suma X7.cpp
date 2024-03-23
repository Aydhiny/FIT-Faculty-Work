#include <iostream>

using namespace std;

void main() {

	float n;
	float s = 0.00f;
	float s2 = 0.00f;
	do {
		cout << "Unesite vrijednost n:" << endl;
		cin >> n;

	} while (n < 1 || n >= 16);

	for (int i = 1; i <= n; i++)
	{
		for (int j = 5; j <= 10; j++)
			s += pow(i - j, 2) / pow(j, 2);
		s2 += pow(i, 2) + s;
	}
	cout << s2 << endl;

}