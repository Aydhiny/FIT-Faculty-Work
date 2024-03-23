#include <iostream>

using namespace std;

struct vozilo 
{
	char* markaVozila;
	char* nazivVozila;
	char* tipVozila;
	float* potrosnja_goriva_po_km;

	vozilo() 
	{
		markaVozila = new char[20];
		nazivVozila = new char[20];
		tipVozila = new char;
		potrosnja_goriva_po_km = new float;
	}
	~vozilo() 
	{
		delete[] markaVozila;
		markaVozila = nullptr;
		delete[] nazivVozila;
		nazivVozila = nullptr;
		delete tipVozila;
		tipVozila = nullptr;
		delete potrosnja_goriva_po_km;
		potrosnja_goriva_po_km = nullptr;
		
	}

};

void unosElemenata(vozilo**, int, int);
void ispisElemenata(vozilo**, int, int);
void dealokacijaNiza(vozilo**&, int);
int main() 
{
	int red, kolona;
	cout << "Unesite koliko redova zelite: " << endl;
	cin >> red;

	cout << "Unesite koliko kolona zelite: " << endl;
	cin >> kolona;

	vozilo** niz = new vozilo * [red];

	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new vozilo[kolona];
	}

	unosElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	dealokacijaNiza(niz, red);

}

void unosElemenata(vozilo** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cin.ignore();
			cout << "Unesite marku vozila: " << endl;
			cin.getline ((*(niz + i) + j)->markaVozila, 20);
			cout << "Unesite naziv Vozila: " << endl;
			cin.getline((*(niz + i) + j)->nazivVozila, 20);
			do 
			{
				cout << "Unesite Tip Vozila: " << endl;
				cin >> (*(*(niz + i) + j)->tipVozila);
			} while (*(*(niz + i) + j)->tipVozila != 'A' && *(*(niz + i) + j)->tipVozila != 'B' && *(*(niz + i) + j)->tipVozila != 'C');

			cout << "Unesite Potrosnju goriva vozila: " << endl;
			cin >> (*(*(niz + i) + j)->potrosnja_goriva_po_km);
		}
	}
}

void ispisElemenata(vozilo** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Marka vozila je: " << ((*(niz + i) + j)->markaVozila) << endl;
			cout << "Naziv vozila je: " << ((*(niz + i) + j)->nazivVozila) << endl;
			cout << "Tip Vozila je: " << (*(*(niz + i) + j)->tipVozila) << endl;
			cout << "Potrosnja goriva je: " << (*(*(niz + i) + j)->potrosnja_goriva_po_km) << endl;
		}
	}
}


void dealokacijaNiza(vozilo**& niz, int red) 
{
	for (int i = 0; i < red; i++) 
	{
		delete[] * (niz + i);
	}

	delete[] niz;
	niz = nullptr;
}