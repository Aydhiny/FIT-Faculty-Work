#include <iostream>

using namespace std;

int obrni(int);
int parneCifre(int);
int main() 
{
	int n;
	cout << "Unesite broj n: " << endl;
	cin >> n;

	cout << "Vas broj zamjenjen je: " << parneCifre(obrni(n)) << endl;
	return 0;
}

int obrni(int br) 
{
	int temp, novi = 0;
	while (br) 
	{
		temp = br % 10;
		novi = novi * 10 + temp;
		br /= 10;
	}
	return novi;
}

int parneCifre(int br) 
{
	int temp, novi = 0;
	while(br) 
	{
		temp = br % 10;
		if (temp % 2 == 0) 
		{
			novi = novi * 10 + 5;
			br /= 10;
		}
		else 
		{
			novi = novi * 10 + temp;
			br /= 10;
		}
	}

	return novi;
}