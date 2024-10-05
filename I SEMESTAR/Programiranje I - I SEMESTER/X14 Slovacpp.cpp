#include <iostream>

using namespace std;

void main() {

	char suglasnik;

	do {
		cout << "Unesite suglasnika: " << endl;
		cin >> suglasnik;

	} while (suglasnik == 'A' || suglasnik == 'E' || suglasnik == 'I' || suglasnik == 'O' || suglasnik == 'U' || suglasnik == 'a' || suglasnik == 'e' || suglasnik == 'i' || suglasnik == 'o' || suglasnik == 'u');

	suglasnik-= 1;
	cout << suglasnik << endl;
	suglasnik= suglasnik + 2;
	cout << suglasnik;
}
char Pile(char suglasnik) {

	if (suglasnik == 'Z') return 'A';
	if (suglasnik == 'z') return 'a';
	return char(suglasnik + 1);
}