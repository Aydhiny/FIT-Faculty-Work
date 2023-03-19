#include <iostream>

using namespace std;

bool jePalindrom(int);
void Golbach(int);

int main() 
{
	int n1, n2;
	cout << "Unesite vrijednosti n1 i n2: " << endl;
	cin >> n1 >> n2;
	int temp;
	if (n1 > n2) 
	{
		temp = n1;
		n1 = n2;
		n2 = temp;
	}

	for (int i = n1; i <= n2; i++) 
	{
		Golbach(i);
	}

	return 0;
	system("pause<nul");
}

bool jePalindrom(int br) 
{
	// 1  321
	int temp, novi = 0;
	int copy = br;
	while (br > 0) 
	{
		temp = br % 10;
		novi = novi * 10 + temp;
		br /= 10;
	}
	if (novi == copy)
		return true;

	return false;
}

void Golbach(int br) 
{
	for (int i = br / 2, j = br / 2; i <= br; i++, j--) 
	{
		if (jePalindrom(i) && jePalindrom(j)) 
		{
			if (i + j == br) 
			{
				cout << i << "+" << j << "=" << br << endl;
			}
		}
	}
}