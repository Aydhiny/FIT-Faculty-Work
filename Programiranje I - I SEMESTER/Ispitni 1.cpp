#include <iostream>

using namespace std;

int main() 
{
	int n;
	do 
	{
		cout << "Unesite prirodan broj n: " << endl;
		cin >> n;
	} while (n < 0);

	float suma = 0.00f;
	for (int i = n, j = 1; i >= 1; i--, j++) 
	{
		suma += n - i / pow((2 * j + 1), 2);
	}

	cout << "Suma iznosi: " << suma << endl;
	cout << "Formula: suma += i / pow((2 * j + 1), 2)" << endl;

	system("pause>nul");
	return 0;
}