#include <iostream>

using namespace std;
int BrojanjeCifara(int);
int br;

void main() {

	cout << "Unesite broj N: " << endl;
	cin >> br;
	cout << "Broj cifara je: " << BrojanjeCifara(br) << endl;

}

int BrojanjeCifara(int br)
{
	int brojacCifara = 0;
	while (br > 0) {

		br /= 10;
		brojacCifara++;
	}
	return brojacCifara;
}