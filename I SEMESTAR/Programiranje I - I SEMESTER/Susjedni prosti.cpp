#include <iostream>
#include <ctime>
using namespace std;

bool jeProst(int);
int main() 
{
	srand(time(NULL));
	float n;
	do 
	{
		cout << "Unesite vrijednost n: " << endl;
		cin >> n;
	} while (n < 10 || n > 1000);


	float dvaUzastopna = 0, brojac = 0;
	int randBroj = 0;
	
	for(int i = 0; i < n; i++) 
	{
		randBroj = rand() % 1000 + 1;
		if (jeProst(randBroj))
		{
			cout << "Prost: " << randBroj << endl;
			brojac++;
		}
		else 
		{
			cout << randBroj << endl;
			brojac = 0;
		}

		if (brojac == 2)
			dvaUzastopna++;
	}
	cout << "Susjedni prosti brojevi su se pojavili: " << (dvaUzastopna / n) * 100 << "%" << endl;

	system("pause<nul");
	return 0;
}

bool jeProst(int br) 
{
	if (br == 0 || br == 1)
		return false;
	for (int i = 2; i < br; i++) 
	{
		if (br % i == 0)
			return false;
	}
	return true;
}