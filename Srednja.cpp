#include <iostream>

using namespace std;

void sortiranje(int*, int);
void rekurzija(int*, int, int);
int main() 
{
	int n = 20;

	int* niz = new int[n];
	rekurzija(niz, n, 0);
	for (int i = 0; i < n; i++) 
	{
		cout << *(niz + i) << "|";
	}
	cout << endl;
	cout << "Poslije sorta: " << endl << endl;
	sortiranje(niz, n);
	for (int i = 0; i < n; i++)
	{
		cout << *(niz + i) << "|";
	}

	return 0;
}

int srednjaCifra(int br) 
{
	int brojCifri = log10(br) + 1;
	if (brojCifri % 2 == 0)
	{
		br = br / pow(10, brojCifri / 2 - 1);
		int temp = br % 10;
		temp += (br / 10) % 10;
		return temp / 2;
	}
	else 
	{
		br = br / pow(10, brojCifri / 2);
		return br % 10;
	}
}

void rekurzija(int* niz, int vel, int brojac) 
{
	if (brojac == vel)
		return;
	else 
	{
		if (brojac == 0)
			*(niz + brojac) = 1;
		else if (brojac == 1)
			*(niz + brojac) = 1;
		else if (*(niz + brojac - 2) + *(niz + brojac - 1) < 0)
			return;
		else
			*(niz + brojac) = *(niz + brojac - 2) + *(niz + brojac - 1);
	}
	rekurzija(niz, vel, brojac + 1);
}

void sortiranje(int* niz, int n) 
{
	bool zastava = true;
	do
	{
		zastava = false;
		for (int i = 0; i < n - 1; i++) 
		{
			if(srednjaCifra(niz[i]) > srednjaCifra(niz[i + 1]))
			{
				zastava = true;
				int temp = niz[i];
				niz[i] = niz[i + 1];
				niz[i + 1] = temp;
			}
		}
	} while (zastava);
}