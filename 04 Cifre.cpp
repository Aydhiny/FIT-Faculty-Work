#include <iostream>

using namespace std;


int brojCifara(int);
int zadnjaCifra(int);
int prvaCifra(int);
int srednjaCifra(int);

void main() 
{

	int n;
	cout << "Unesite vrijednost N: " << endl;
	cin >> n;


	cout << "Broj cifara ovog kurca je: " << brojCifara(n) << endl;
	cout << "Zadnja cifra ovog kurca je: " << zadnjaCifra(n) << endl;
	cout << "Prva cifra ovog kurca je: " << prvaCifra(n) << endl;
	cout << "Srednja cifra ovog kurca je: " << srednjaCifra(n) << endl;

}

int brojCifara(int br)
{

	int brojac = 0;
	while (br > 0) {
	br /= 10;

	brojac++;

	}
	return brojac;

}

int zadnjaCifra(int br) 
{
	return br % 10 ;

}

int prvaCifra(int br) {

	while (br > 10) {
		br /= 10;
	}
	
	return br;

}

int srednjaCifra(int br) {

	int ukloni = brojCifara(br) / 2;
	int srednja;

	if (ukloni % 2 == 0) {

	br/= pow(10, ukloni);
	srednja = br % 10;
	return srednja;

	}
	else {

		cout << "Jebem ti mater" << endl;
		return 0;
	}

}
