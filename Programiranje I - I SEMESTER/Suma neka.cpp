#include <iostream>

using namespace std;

int main() 
{
	int n;
	cout << "Unesite velicinu n: " << endl;
	cin >> n;

	float GS = 1.00f;
	int brojac = 0;
	for (int i = 1; i <= n; i++) 
	{
		if(i % 5 != 0) 
		{
			GS *= i;
			brojac++;
		}
	}
	cout << "Geometrijska suma intervalu je: " << pow(GS, 1 / brojac) << endl;
	return 0;
}

