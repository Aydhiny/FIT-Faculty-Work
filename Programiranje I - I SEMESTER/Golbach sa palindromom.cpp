#include <iostream>

using namespace std;

bool jePalindrom(int);
void Golbach(int);
int main() 
{
	int n, m;
	do 
	{
		cout << "Unesite n i m: " << endl;
		cin >> n >> m;
	} while (n < 200 && m < n);


	for (int i = n; i < m; i++) 
	{
		Golbach(i);
	}
	return 0;
}

void Golbach(int br) 
{
	for (int i = br / 2, j = br /2; i < br; i++, j--) 
	{
		if (jePalindrom(i) && jePalindrom(j))
		{
			cout << i << "+" << j << "=" << br << endl;
		}
	}
}

bool jePalindrom(int br) 
{
	if (br == 0)
		return false;

	int temp, novi = 0;
	int broj2 = br;
	while (br) 
	{
		temp = br % 10;
		novi = novi * 10 + temp;
		br /= 10;
	}
	if (broj2 == novi)
		return true;

	return false;
}