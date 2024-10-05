/*2 broja se unose, od n do m, svaki parni 
broj se izrazi kao zbir 2 broja*/

#include <iostream>
#include <cmath>

using namespace std;
bool prost(int);

int main() {

	int a, b;
	do {
		cout << "Unesite 2 broja" << endl;
		cin >> b;
		cin >> a;

	} while (a < 10 || a> b);

	//Kontrola koda - formula
	(a % 2 != 0) ? a++ : 1;

	for (int i = a; i <= b; i+=2)
	{
		//ovo je zadaca, optimiziraj
		for (int j = i / 2, k = i / 2; j < i; j++, k--) 
		{
			if (prost(j) && prost(k)) {
			cout << j << " + " << k << " = " << j + k << endl;
			break;
			}
		}

	}

	system("pause<nul");
	return 0;

}

bool Prost(int br) {

	if (br < 2) 
		return false;

	for (int i = 2; i < br / 2; i++) {

		if (br % i == 0) {
			return false;
		}

	}
	return true;
}