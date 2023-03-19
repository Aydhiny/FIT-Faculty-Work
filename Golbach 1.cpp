#include <iostream>
#include <cmath>


/*Svaki paran broj moze se prikazati kao suma dvaju prostih brojeva (tzv, Golbachovo pravilo)
Razgraditi logiku programa koji ce najprije ucitati 2 pr broja n1 i n2. Ako je n1 > n2 zamijeniti
n1 sa n2. Prikazati sve parne cifre u intervalu n1 do n2 kao sumu dvaju prostih bojeva.
U glavnom programu samo unijeti navedena 2 pr broja i pozvati funkciju koja obavlja zadani posao.*/

using namespace std;
bool paranBroj(int);

void main() {

	int n1;
	int n2;
	int temp = 1;

	do {
		cout << "Unesite vrijednosti n1 i n2: " << endl;
		cin >> n1 >> n2;
	} while (n1 < 0 || n2 < 0);

	if (n1 > n2) {

		n1 = temp;
		n1 = n2;
		temp = n2;
	}


	system("pause<null");
}

bool paranBroj(int br) {


}