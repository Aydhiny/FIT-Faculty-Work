#include <iostream>

using namespace std;

struct vozilo
{
	char* markaVozila;
	char* brojSasije;
	char* tipVozila;
	int* kubniCM;

	vozilo() 
	{
		markaVozila = new char[20];
		brojSasije = new char[25];
		tipVozila = new char;
		kubniCM = new int;
	}
	~vozilo() 
	{
		delete[]markaVozila;
		markaVozila = nullptr;
		delete[]brojSasije;
		brojSasije = nullptr;
		delete tipVozila;
		tipVozila = nullptr;
		delete kubniCM;
		kubniCM = nullptr;
	}
};

void unosElemenata(vozilo**, int, int);
void dealokacijaNiza(vozilo** , int );
int main() 
{
	int red, kolona;
	cout << "Unesite redove i kolone: " << endl;
	cin >> red >> kolona;

	vozilo** niz = new vozilo * [red];
	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new vozilo[kolona];
	}

	unosElemenata(niz, red, kolona);
	void ispisElemenata(vozilo **, int, int);
	dealokacijaNiza(niz, red);
}

void unosElemenata(vozilo** niz, int red, int kolona) 
{
	cin.ignore();
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Unesite marku vozila: " << endl;
			cin.getline((*(niz + i) + j)->markaVozila, 20);
			cout << "Unesite broj sasije vozila: " << endl;
			cin.getline((*(niz + i) + j)->brojSasije, 25);
			do 
			{
				cout << "Unesite tip vozila: (A, B, C)" << endl;
				cin >> *(*(niz + i) + j)->tipVozila;
			} while (*(*(niz + i) + j)->tipVozila != 'A' && *(*(niz + i) + j)->tipVozila && 'B' && *(*(niz + i) + j)->tipVozila != 'C');
			*(*(niz + i) + j)->kubniCM = rand() % 1000 + 1;
		}
	}
}

void ispisElemenata(vozilo** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++)
	{
		for (int j = 0; j < kolona; j++)  
		{
			cout << (*(niz + i) + j)->markaVozila << "\t";
			cout << (*(niz + i) + j)->brojSasije << "\t";
			cout << *(*(niz + i) + j)->tipVozila << endl;
		}
		cout << endl;
	}
}

void dealokacijaNiza(vozilo** niz, int red) 
{
	for (int i = 0; i < red; i++) 
	{
		delete[] * (niz + i);
	}
	delete[] niz;
	niz = nullptr;
}