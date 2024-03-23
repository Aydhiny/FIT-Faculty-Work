#include <iostream>

using namespace std;

int main() {

	int novac;
	int konverzija;
	int i;

	cout << "Unesite novcanu vrijednost: " << endl;
	cin >> novac;

	cout << "Unesite konverziju: " << endl;
	cout << "1 - KM to $" << endl;
	cout << "2 - KM to Euro" << endl;
	cout << "3 - KM to Yen" << endl;
	cin >> konverzija;


	
		switch (konverzija) {
		case(1):
			novac = novac * 1.95;
			cout << "Vas iznos novca u dolarima je: " << novac << endl;
			break;
		case(2):
			novac = novac * 1.91;
			cout << "Vas iznos novca u eurima je " << novac << endl;
			break;
		case(3):
			novac = novac * 0.52;
			cout << "Vas iznos novca u yenima je: " << novac << endl;
			break;
		case(4):
			break;
		default:
			cout << "ERROR Pogresna vrijednost!" << endl;
			break;
		}
		

	return 0;
}