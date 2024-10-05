#include <iostream>
#include <ctime> 
using namespace std;

bool jeSavrsen(int);
int main() 
{
	srand(time(NULL));
	int n;

	do 
	{
		cout << "Unesite n: " << endl;
		cin >> n;
	} while (n < 10 || n > 1000);

	int randomBroj;

	for (int i = 1; i < n; i++) 
	{
		randomBroj = rand() % 1000 + 1;
		if (jeSavrsen(randomBroj))
			cout << "Savrseni: " << randomBroj << endl;
		else
			cout << randomBroj << endl;
	}

}

bool jeSavrsen(int br) 
{
	int suma = 0;
	for (int i = 1; i < br; i++) 
	{
		if (br % i == 0)
			suma += i;
	}
	if (suma == br)
		return true;

	return false;
}