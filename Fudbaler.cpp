#include <iostream>

using namespace std;

struct fudbaler 
{
	int* godRodjenja;
	int* brojIgraca;
	int* golovi;

	fudbaler() 
	{
		godRodjenja = new int;
		brojIgraca = new int;
		golovi = new int;
	}
	~fudbaler() 
	{
		delete godRodjenja;
		godRodjenja = nullptr;
	
	}
};

int main()
{
	long long int broj;
	cin >> broj;
	long long int brojCifri = log10(broj) + 1;
	cout << "Broj cifri je: " << brojCifri << endl;



}