/*a) Omogućiti korisniku unos prirodnog broja i nakon toga napraviti funkciju koja će prebrojati koliko taj broj ima cifara

b) Za taj broj pronaći i ispisati prvu, srednju i zadnju cifu (koristiti zasebne funkcije)

c) Obrnuti cifre tom broju (npr. ako je broj bio 12345 treba biti 54321)*/

#include <iostream>

using namespace std;

int BrojanjeCifara(int);
int PrvaCifra(int);
int SrednjaCifra(int);
int ZadnjaCifra(int);
int ObrnuteCifre(int);

void main() {

	int broj;
	cout << "Unesite neki broj: " << endl;
	cin >> broj;
	cout << "Broj koji ste unijeli ima: " << BrojanjeCifara(broj) << " Cifara" << endl;
	cout << PrvaCifra(broj) << " Prva Cifra" << endl;
	cout << SrednjaCifra(broj) << " Srednja Cifra" << endl;
	cout << ZadnjaCifra(broj) << " Zadnja Cifra" << endl;
	cout << ObrnuteCifre(broj) << " Obrnuta Cifra" << endl;

	system("pause");
}

int BrojanjeCifara(int br)
{
	//1234
	int brojacCifara = 0;
	while (br > 0) {

		br /= 10;
		brojacCifara++;
	}
	return brojacCifara;
}
int PrvaCifra(int br) {
	//1234 / 10 = 123.4 = 12.3 / 1.3

	while (br > 10) {

		br = br / 10;
	}
	return br;

}

int SrednjaCifra(int br) {

	//123456// 
	int kolikoOtkinuti = BrojanjeCifara(br)/2;
	br = br / pow(10, kolikoOtkinuti);
	//123
	return br % 10;

}

int ZadnjaCifra(int br) {

	return br % 10;
}

int ObrnuteCifre(int br) {

	//123 //321
	int novi = 0, temp = 0;
	while (br > 0) {

		temp = br % 10;
		novi = novi * 10 + temp;
		br /= 10;
	}
	return novi;
}