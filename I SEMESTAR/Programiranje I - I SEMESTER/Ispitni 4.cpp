#include <iostream>
#include <ctime>

using namespace std;


struct figura
{
	int ID;
	char* nazivFigure;
	float* visinaFigure;
	figura()
	{
		ID = 0;
		nazivFigure = new char[20];
		visinaFigure = new float;
	}
	~figura()
	{
		delete[]nazivFigure;
		nazivFigure = nullptr;
		delete visinaFigure;
		visinaFigure = nullptr;
	}
};

void unosElemenata(figura**, int, int);
void ispisElemenata(figura**, int, int);
void dealokacijaNiza(figura**& niz, int red);
int main()
{
	srand(time(NULL));
	int red, kolona;
	cout << "Unesite redove i kolone: " << endl;
	cin >> red >> kolona;

	figura** niz = new figura * [red];
	for (int i = 0; i < red; i++)
	{
		*(niz + i) = new figura[kolona];
	}

	unosElemenata(niz, red, kolona);
	ispisElemenata(niz, red, kolona);
	dealokacijaNiza(niz, red);

	return 0;
}

void unosElemenata(figura** niz, int red, int kolona)
{
	cin.ignore();
	for (int i = 0; i < red; i++) 
	{
		for (int j = 0; j < kolona; j++)  
		{
			(*(niz + i) + j)->ID = rand() % 100 + 1;
			cout << "Unesite naziv figure: " << endl;
			cin.getline((*(niz + i) + j)->nazivFigure, 20);
			*(*(niz + i) + j)->visinaFigure = rand() % 100 + 1;
		}
	}
}

void ispisElemenata(figura** niz, int red, int kolona) 
{
	for (int i = 0; i < red; i++)
	{
		for (int j = 0; j < kolona; j++)
		{
			cout << "ID figure: " << (*(niz + i) + j)->ID << "\t";
			cout << "Naziv figure: " << (*(niz + i) + j)->nazivFigure << "\t";
			cout << "Visina figure: " << * (*(niz + i) + j)->visinaFigure << endl;
		}
	}
}
 
void dealokacijaNiza(figura**& niz, int red) 
{
	for (int i = 0; i < red; i++) 
	{
		delete[] * (niz + i);
	}
	delete[] niz;
	niz = nullptr;
}