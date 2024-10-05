#include <iostream>

using namespace std;

void main() 
{
	int rezultat = 0.00f;
	int n;

	do {
		cout << "Unesite vrijednost N: " << endl;
		cin >> n;
	} while (n > 100 || n < 0);


	for (int i = 1; i <= n; i++) 
	{

		rezultat += pow(i, 2) / sqrt(i);

	}

	cout << "Rezultat je: " << rezultat << endl;



}