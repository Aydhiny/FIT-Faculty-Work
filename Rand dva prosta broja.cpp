#include <iostream>
#include <ctime>
using namespace std;

bool jeProst(int);
int main() 
{
	srand(time(NULL));
	int n;

	do 
	{
		cout << "Unesite interval n: " << endl;
		cin >> n;
	} while (n < 10 || n > 1000);

	float brojac = 0, dvaIsta = 0;
	int randBroj;
	for (int i = 0; i < n; i++) 
	{
		randBroj = rand() % 1000 + 1;

		if (jeProst(randBroj) == false)
			cout << randBroj << endl;

		if (jeProst(randBroj))
		{
			dvaIsta++; 
			cout << "Prost: " << randBroj << endl;
		}
		else
			dvaIsta = 0;

		if (dvaIsta == 2)
		{
			brojac++;
		}
	}
		cout << "Broj susjednih prostih brojeva: " << brojac << endl;
		cout << "Procenat prostih brojeva: " << (brojac / n) * 100 << "%" << endl;
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