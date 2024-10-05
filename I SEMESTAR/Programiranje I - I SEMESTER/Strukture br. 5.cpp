#include <iostream>
#include <cstdlib>
using namespace std;

struct vremenska_prognoza
{
	char* padavine;
	float* temperature;
	float* vlaznost_vazduha;

	vremenska_prognoza() 
	{
		padavine = new char[20];
		temperature = new float;
		vlaznost_vazduha = new float;
	}
	~vremenska_prognoza() 
	{
		delete[]padavine;
		padavine = nullptr;
		delete temperature;
		temperature = nullptr;
		delete vlaznost_vazduha;
		vlaznost_vazduha = nullptr;
	}
};

void unosElemenata(vremenska_prognoza**, int, int);
void ispisElemenata(vremenska_prognoza**, int, int);
void dealokacijaNiza(vremenska_prognoza**& , int );
int main() 
{
	int red, kolona;
	cout << "Unesite redove: " << endl;
	cin >> red;

	cout << "Unesite kolone: " << endl;
	cin >> kolona;

	vremenska_prognoza** niz = new vremenska_prognoza*[red];

	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new vremenska_prognoza [kolona];
	}
	unosElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	dealokacijaNiza(niz, red);


	cin.get();
	return 0;
}

void unosElemenata(vremenska_prognoza** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cin.ignore();
			cout << "Unesite padavine: " << endl;
			cin.getline((*(niz + i) + j)->padavine, 20);
			cout << "Unesite temperaturu: " << endl;
			cin >> *(*(niz + i) + j)->temperature;
			cout << "Unesite vlaznost vazduha: " << endl;
			cin >> *(*(niz + i) + j)->vlaznost_vazduha;
		}
	}
}

void ispisElemenata(vremenska_prognoza** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Padavine: " << ((*(niz + i) + j)->padavine) <<endl;
			cout << "Temperatura: " << *((*(niz + i) + j)->temperature) << endl;
			cout << "Vlaznost vazduha: " << *((*(niz + i) + j)->vlaznost_vazduha) << endl;
		}
		cout << "\n";
	}
}

void dealokacijaNiza(vremenska_prognoza**& niz, int red) 
{
	for (int i = 0; i < red; i++) 
	{
		delete * (niz + i);
	}
	delete[]niz;
	niz = nullptr;
}