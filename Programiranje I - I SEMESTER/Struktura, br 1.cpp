#include <iostream>
#include <ctime>
using namespace std;

struct uposlenik 
{
	char* ID;
	char* imePrezime;
	float* plata;

	uposlenik() 
	{
		ID = new char[10];
		imePrezime = new char[20];
		plata = new float;
	}
	~uposlenik() 
	{
		delete[]ID;
		ID = nullptr;
		delete[]imePrezime;
		imePrezime = nullptr;
		delete plata;
		plata = nullptr;
	}

};

void ispisElemenata(uposlenik**, int, int);
void dealokacijaNiza(uposlenik**&, int);
void unosElemenata(uposlenik**, int, int);
void odjel_sa_Najvecim_prosjekom(uposlenik**, int, int);
int main() 
{
	srand(time(NULL));
	//red = firma //kolona = radnik
	int red, kolona;
	cout << "Unesite redove: " << endl;
	cin >> red;

	cout << "Unesite kolonu: " << endl;
	cin >> kolona;

	uposlenik** niz = new uposlenik*[red];
	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new uposlenik [kolona];
	}
	unosElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	odjel_sa_Najvecim_prosjekom(niz, red, kolona);
	dealokacijaNiza(niz, red);

}

void dealokacijaNiza(uposlenik**& niz, int red) 
{
	for (int i = 0; i <red; i++) 
	{
		delete[] *(niz + i);
		*(niz + i) = nullptr;
	}
	delete[]niz;
	niz = nullptr;
}

void unosElemenata(uposlenik** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Unesite ID zaposlenika: " << endl;
			cin.ignore();
			cin.getline((*(niz + i) + j)->ID, 10);
			cout << "Unesite Ime i Prezime uposlenika: " << endl;
			cin.getline((*(niz + i) + j)->imePrezime, 20);
			*(*(niz + i) + j)->plata = rand() % 3000 + 1500;
		}
	}
}

void ispisElemenata(uposlenik** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "ID uposlenika je: " << (*(niz + i) + j)->ID << endl;
			cout << "Ime i prezime uposlenika je: " << (*(niz + i) + j)->imePrezime << endl;
			cout << "Plata uposlenika je: " << *(*(niz + i) + j)->plata << "KM" << endl;
		}
	}
}

void odjel_sa_Najvecim_prosjekom(uposlenik** niz, int red, int kolona) {
	double* prosjekOdjela = new double[red] {};
	for (int i = 0; i < red; i++)
	{
		for (int j = 0; j < kolona; j++)
		{
			*(prosjekOdjela + i) += *(*(niz + i) + j)->plata;
		}
		*(prosjekOdjela + i) /= kolona;
	}
	int najbolji_prosjek_Indeks = 0;
	for (int i = 0; i < red; i++)
	{
		if (*(prosjekOdjela + i) > *(prosjekOdjela + najbolji_prosjek_Indeks)) 
		{
			najbolji_prosjek_Indeks = i;
		}
	}
	cout << "Indeks odjela (reda) sa najvecim prosjekom je: " << najbolji_prosjek_Indeks << " a najbolji prosjek je: " << *(prosjekOdjela + najbolji_prosjek_Indeks) << endl;
	delete[]prosjekOdjela; 
	prosjekOdjela = nullptr;

}