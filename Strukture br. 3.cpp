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
		brojSasije = new char[15];
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

void upisElemenata(vozilo**, int, int);
void ispisElemenata(vozilo**, int, int);
void dealokacijaNiza(vozilo**&, int);
void main() 
{
	int red, kolona;
	cout << "Unesite koliko redova zelite: " << endl;
	cin >> red;
	cout << "Unesite koliko kolona zelite: " << endl;
	cin >> kolona;

	vozilo** niz = new vozilo *[red];
	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new vozilo [kolona];
	}

	upisElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	dealokacijaNiza(niz, red);
	cin.get();
}

void upisElemenata(vozilo** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cin.ignore();
			cout << "Unesite marku vozila: " << endl;
			cin.getline ((*(niz + i) + j)->markaVozila, 20);
			cout << "Unesite Broj sasije vozila: " << endl;
			cin.getline((*(niz + i) + j)->brojSasije, 15);
			do 
			{
				cout << "Unesite tip vozila (A, B, C) : " << endl;
				cin >> (*(*(niz + i) + j)->tipVozila);
			} while (*(*(niz + i) + j)->tipVozila != 'A' && *(*(niz + i) + j)->tipVozila != 'B' && *(*(niz + i) + j)->tipVozila != 'C');
			cout << "Unesite kubikazu vozila: " << endl;
			cin >> *(*(niz + i) + j)->kubniCM;
		}
	}
}
void ispisElemenata(vozilo** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Marka vozila: " << ((*(niz + i) + j)->markaVozila, 20) << endl;
			cout << "Broj sasije vozila: " << ((*(niz + i) + j)->brojSasije, 15) << endl;
			cout << "tip vozila: " << (*(*(niz + i) + j)->tipVozila) << endl;
			cout << "Kubikaza vozila: " << *(*(niz + i) + j)->kubniCM << endl;
		}
	}
}

void dealokacijaNiza(vozilo**& niz, int red) 
{
	for (int i = 0; i < red; i++) 
	{
		delete[] * (niz + i);
	}
	delete[]niz;
	niz = nullptr;
}