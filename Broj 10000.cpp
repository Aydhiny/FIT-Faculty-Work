#include <iostream>
using namespace std;

int main()
{
	int a ;
	int b ;
	int ostatak ;
	int obrnutibroj = 0;
	do
	{
		cout << "unesi a:" << endl;
		cin >> a;
		while (a != 0) {
			ostatak = a % 10;
			obrnutibroj = obrnutibroj * 10 + ostatak;
			a /= 10;
		}
	} while (a <= 10000);
	cout << "unesite broj ponovo" << endl;

}

