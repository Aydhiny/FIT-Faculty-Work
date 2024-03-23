#include <iostream>
#include <ctime>
using namespace std;

const int vel = 100;
bool jeProst(int);
int main() 
{
	srand(time(NULL));
	int niz[vel];
	int randBroj;
	float brojac = 0;
	for (int i = 1; i < vel; i++)
	{
		randBroj = rand() % 100000 + 1;
		if (randBroj > 100)
			niz[i] = randBroj;
		if (log10(niz[i]) + 1 % 2 != 0)
		{
			if (jeProst(niz[i])) 
			{
				cout << niz[i] << endl;
				brojac++;
			}
		}
	}
	cout << "Prostih brojeva u nizu je: " << float((brojac / vel) * 100) << "%" << endl;
}

bool jeProst(int br) 
{
	for (int i = 2; i < br; i++) 
	{
		if (br % i == 0)
			return false;
	}
	return true;
}