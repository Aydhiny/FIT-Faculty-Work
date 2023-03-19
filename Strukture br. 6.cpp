#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

struct kosarkas 
{
	char* ID;
	char* imePrezime;
	int* postignutiKosevi;

	kosarkas() 
	{
		ID = new char[10];
		imePrezime = new char[25];
		postignutiKosevi = new int;
	}
	~kosarkas() 
	{
		delete[]ID;
		ID = nullptr;
		delete[]imePrezime;
		imePrezime = nullptr;
		delete postignutiKosevi;
		postignutiKosevi = nullptr;
	}
};

void unosElemenata(kosarkas** , int , int);
void ispisElemenata(kosarkas** ,int, int);
int uspjehKluba(kosarkas** , int , int );
void dealokacijaNiza(kosarkas**& , int );
int main() 
{
	srand(time(0));
	int red, kolona;
	cout << "Unesite koliko redova zelite: " << endl;
	cin >> red;
	cout << "Unessite koliko kolona zelite: " << endl;
	cin >> kolona;

	kosarkas** niz = new kosarkas * [red];
	for (int i = 0; i < red; i++) 
	{
		*(niz + i) = new kosarkas[kolona];
	}

	unosElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	cout << endl;
	cout << "Klub koji je najuspijesniji tj. koji ima najvise koseva je na indeksu: " << uspjehKluba(niz, red, kolona);
	cout << "\n";

	cout << "Ispis najuspijesnijeg kluba: " << endl;
	int indeks = uspjehKluba(niz, red, kolona);
	for (int i = 0; i < red; i++)
	{
		cout << "ID igraca je: " << (*(niz + i) + indeks)->ID << "\t";
		cout << "Ime i Prezime igraca je: " << (*(niz + i) + indeks)->imePrezime << "\t";
		cout << "Broj postignutih koseva od igraca je: " << *(*(niz + i) + indeks)->postignutiKosevi << endl;
	}

	dealokacijaNiza(niz, red);
	cin.get();
	return 0;
}

void unosElemenata(kosarkas** niz, int red, int kolona) 
{
	cin.ignore();
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "Unesite ID kosarkasa: " << endl;
			cin.getline((*(niz + i) + j)->ID, 10);
			cout << "Unesite Ime i prezime: " << endl;
			cin.getline((*(niz + i) + j)->imePrezime, 25);
			*(*(niz + i) + j)->postignutiKosevi = rand() % 20 + 1;
		}
	}
}

void ispisElemenata(kosarkas** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			cout << "ID kosarkasa: " << ((*(niz + i) + j)->ID) << endl;
			cout << "Ime i Prezime kosarkasa: " << ((*(niz + i) + j)->imePrezime) << endl;
			cout << "Postignuti kosevi: " << *(*(niz + i) + j)->postignutiKosevi << endl;
		}
	}
}

int uspjehKluba(kosarkas** niz, int red, int kolona) 
{
	int* pomocni = new int[kolona] {};
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++) 
		{
			*(pomocni + i) += *(*(niz + j) + i)->postignutiKosevi;
		}
	}

	int maxKlub = 0;
	for (int i = 0; i < kolona; i++)
	{
		if (*(pomocni + i) > *(pomocni + maxKlub))
		{
			maxKlub = i;
		}
	}

	delete[] pomocni;
	pomocni = nullptr;
	return maxKlub;
}

int* maxIgrac(kosarkas** niz, int red, int kolona, int max_klub) {

	int* najgori = new int[red] {};
	int* pomocni = new int[red] {};

	for (int i = 0; i < red; i++)
	{
		*(pomocni + i) = *(*(niz + i) + max_klub)->postignutiKosevi;
	}

	int najbolji = *(pomocni + 0);

	for (int i = 0; i < red; i++)
	{
		if (*(pomocni + i) > najbolji) {
			najbolji = *(pomocni + i);
		}
	}

	for (int i = 0; i < red; i++)
	{
		for (int j = 0; j < kolona; j++)
		{
			*(najgori + i) += *(*(niz + i) + j)->postignutiKosevi; 
		}
	}

	int najgoriK = *(najgori + 0);

	for (int i = 0; i < red; i++)
	{
		if (*(najgori + i) < najgoriK) {
			najgoriK = *(najgori + i);
		}
	}

	int razlikaK = abs(najbolji - najgoriK); 

	cout << "Najbolji kosarkas u klubu " << max_klub << " ima " << najbolji << " koseva" << endl;
	cout << "Najgori kosarkas u cijeloj ligi ima koseva:  " << najgoriK << endl;

	delete[]pomocni;
	pomocni = nullptr;
	delete[]najgori;
	najgori = nullptr;

	return new int(razlikaK); 
}

void dealokacijaNiza(kosarkas**& niz, int red) 
{
	for (int i = 0; i < red; i++) 
	{
		delete[]* (niz + i);
	}
	delete[]niz;
	niz = nullptr;
}