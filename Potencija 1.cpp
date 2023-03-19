#include <iostream>

using namespace std;

int powRekurzija(int, int );
int main() 
{
	int n;
	cout << "Unesite prirodan broj n: " << endl;
	cin >> n;
	int m = n;
	int k = 2, l = 2;
	bool zastava = true;
	while (zastava) 
	{
		int potencija = powRekurzija(k, l);
		if (potencija < m)
			l++;
		else if (sqrt(m) + 1 < k)
		{
			m++, k = 2, l = 2;
		}
		else if (potencija > m)
		{
			k++; l = 2;

		}
		else
			zastava = false;
	
	}
	cout << "Potencija broja: " << k << "^" << l << "=" << powRekurzija(k, l) << endl;

	return 0;
}

int powRekurzija(int k, int l) 
{
	if (l == 1)
		return k;
	return k * powRekurzija(k, l - 1);
}