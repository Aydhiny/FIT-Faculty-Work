#include <iostream>

//Napisati rekurzivnu funkciju za izračunavanje sume parnih od prvih n prirodnih brojeva.
using namespace std;
int rekurzijaSume(int);

int main() 
{

	int n;
	cout << "Unesite prirodni broj N:" << endl;
	cin >> n;
	cout << "Rekurzivna suma parnih brojeva od 1 do: " << n << rekurzijaSume(n) << endl;
}

int rekurzijaSume(int n) 
{
	if (n == 2)
		return 2;
	else
		return n + rekurzijaSume(n - 2);

}