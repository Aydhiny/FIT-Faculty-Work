#include <iostream>

using namespace std;
int brojCifara(int);
int obrniCifre(int);
int prvaCifra(int);
int srednjaCifra(int);
int zadnjaCifra(int);

void main() {

	int broj;
	cout << "Unesite vrijednost: " << endl;
	cin >> broj;
	cout << "Broj cifara ovog broja je: " << brojCifara(broj) << endl;
	cout << "Obrnuti broj: " << obrniCifre(broj) << endl;
	cout << "Prva Cifra: " << prvaCifra(broj) << endl;
	cout << "Zadnja Cifra: " << zadnjaCifra(broj) << endl;
	cout << "Srednja cifra: " << srednjaCifra(broj) << endl;

}

int brojCifara(int br) {

	int brojac = 0;
	while (br > 0) 
	{
		br /= 10;
		brojac++;

	}

	return brojac;

}

int obrniCifre(int br) {

	//1234 123    4321
	int noviBroj = 0;
	int temp = 0;

	while (br > 0) 
	{
		temp = br % 10;
		noviBroj = noviBroj * 10 + temp;
		br /= 10;
	}

	return noviBroj;

}

int prvaCifra(int br) {

	//1234
	while(br > 10) 
	{
		br /= 10;
	}

	return br;
}

int zadnjaCifra(int br) 
{

	return br % 10;

}

int srednjaCifra(int br) 
{
	//123456
	int kolikoOtkinuti = brojCifara(br) / 2;
	if (kolikoOtkinuti / 2 == 0) {
		br = br / pow(10, kolikoOtkinuti);

		return br % 10;

	}
	else {

		cout << "Broj nema srednje cifre jer ima paran broj cifara" << endl;
		return false;
	}
}