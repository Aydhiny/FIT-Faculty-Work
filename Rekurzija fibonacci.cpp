#include <iostream>

using namespace std;

void rekurzija(int*, int, int);
int main() 
{
	int n;
	do 
	{
		cout << "Unesite velicinu niza: " << endl;
		cin >> n;
	} while (n < 0);

	int* niz = new int[n];
	rekurzija(niz, n, 0);
	for (int i = 0; i < n; i++) 
	{
		cout << *(niz + i) << "|";
	}
	cout << endl;


	//Fibonacci, nakon dvije početne vrijedosti, svaki sljedeći broj je zbroj dvaju prethodnika
	//1 + 1 // 2 + 1 // 3 + 2 // 5 + 3 // 8 + 5 // 13// 13 + 8

	delete[] niz;
	niz = nullptr;
	return 0;
}

void rekurzija(int* niz, int vel, int brojac) 
{
	if (brojac == vel)
		return;

	else 
	{
		if (brojac == 0)
			*(niz + brojac) = 1;
		else if (brojac == 1)
			*(niz + brojac) = 1;
		else if (*(niz + brojac - 1) + *(niz + brojac - 2) < 0)
			return;
		else
			*(niz + brojac) = *(niz + brojac - 1) + *(niz + brojac - 2);

	}
	rekurzija(niz, vel, brojac + 1);
}