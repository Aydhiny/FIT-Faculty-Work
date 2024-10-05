#include <iostream>
#include <ctime>
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
		delete brojIgraca;
		brojIgraca = nullptr;
		delete golovi;
		golovi = nullptr;
	
	}
};

void unosElemenata(fudbaler**, int, int);
void ispisElemenata(fudbaler**, int, int);
void dealokacijaNiza(fudbaler**, int);
void tim_sa_najvecim_Prosjekom(fudbaler**, int, int);
int main() 
{
	srand(time(NULL));
	int red, kolona;
	cout << "Unesite broj redova niza: " << endl;
	cin >> red;

	cout << "Unesite broj kolona niza: " << endl;
	cin >> kolona;

	fudbaler** niz = new fudbaler * [red];

	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new fudbaler[kolona];
	}
	unosElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	tim_sa_najvecim_Prosjekom(niz, red, kolona);
	dealokacijaNiza(niz, red);

	cin.get();
}

void unosElemenata(fudbaler** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++)
		{
			*(*(niz + i) + j)->godRodjenja = 1980 + rand() % ((2000 + 1) - 1980);
			*(*(niz + i) + j)->brojIgraca = rand() % 30 + 1;
			*(*(niz + i) + j)->golovi = rand() % 5;
		}
	}
}

void ispisElemenata(fudbaler** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Godina rodjenja fudbalera: " << "\033[31m" << * (*(niz + i) + j)->godRodjenja << "\033[0m" << endl;
			cout << "Broj igraca je: " << "\033[33m" << *(*(niz + i) + j)->brojIgraca << "\033[0m" << endl;
			cout << "Golovi koje je igrac dao: " << "\033[31m" << *(*(niz + i) + j)->golovi << "\033[0m" << endl;
		}
	}
}

void tim_sa_najvecim_Prosjekom(fudbaler** niz, int red, int kolona) {

	// Privremeni float niz inicijaliziran sa 0
	// {} - Inicijalizacija 0
	// U njega pohranjujemo prosjek svakog reda 
	float* najboljiTim = new float[red] {};

	for (int i = 0; i < red; i++)
	{
		for (int j = 0; j < kolona; j++)
		{
			*(najboljiTim + i) += *(*(niz + i) + j)->golovi;
		}
		*(najboljiTim + i) /= kolona;
	}

	int indeksTima = 0;

	for (int i = 0; i < red; i++)
	{
		if (*(najboljiTim + i) > *(najboljiTim + indeksTima)) {
			indeksTima = i;
		}
	}

	cout << "Najbolji tim se nalazi na indeksu: " << indeksTima << " i sa podacima: " << endl;

	for (int j = 0; j < kolona; j++)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	{
		cout << "Godina rodjenja je: " << "\033[33m" << *(*(niz + indeksTima) + j)->godRodjenja << "\033[0m" << "\t" ;
		cout << "Broj igraca je: " << "\033[36m" << *(*(niz + indeksTima) + j)->brojIgraca << "\033[0m" << "\t";
		cout << "Broj golova igraca je: " << "\033[35m" << *(*(niz + indeksTima) + j)->golovi << "\033[0m" << endl;
	}

	cout << endl;

	// Dealociramo niz najboljiTim
	delete[] najboljiTim;
}

void dealokacijaNiza(fudbaler** niz, int red) 
{
	for (int i = 0; i < red; i++)
	{
		delete[] *(niz+i);
	}
	delete[]niz;
	niz = nullptr;
}