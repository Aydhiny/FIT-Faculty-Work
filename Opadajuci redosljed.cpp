#include <iostream>

using namespace std;
bool odbaciti(int);
bool jeOpadajuc(int);
int main() 
{
	int m, n;

	do 
	{
		cout << "Unesite n: " << endl;
		cin >> n;
	} while (n < 10 || n > 1000);

	do 
	{
		cout << "Unesite m: " << endl;
		cin >> m;
	} while (m < n);
	

	for (int i = n; i < m; i++) 
	{
		if (odbaciti(i) && jeOpadajuc(i))
			cout << i << endl;
	}

}
bool odbaciti(int br) 
{
	int temp;
	while (br > 0) 
	{
		temp = br % 10;
		if (temp % 2 == 0)
			return false;

		br /= 10;
	}
	return true;
}

bool jeOpadajuc(int br)
{
	//4 3 5 1
	int maxCifra = 0;
	int temp;
	while (br > 0) 
	{
		temp = br % 10;
		if (maxCifra > temp)
			return false;
		br /= 10;
		maxCifra = temp;
	}
	return true;
}