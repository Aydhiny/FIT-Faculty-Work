#include <iostream>
#include <windows.h>
/*Unos pozitivnog rboja, pronalazi parne 
cifre i mjenja ih sve s brojem 5. Dodatno 
razlika unesenog broja i novog*/

using namespace std;
int zamjenaCifara(int);
int main() {
	int n;
	do
	{
		cout << "Unesite pozitivan broj: " << endl;
		cin >> n;
	} while (n < 0);

	cout << "-----------" << endl;
	cout << "Vas broj sa zamjenom parnih cifri brojem 5 je: " << "\033[31m" << zamjenaCifara(n) << endl;

	cout << "\033[37m";

	system("pause");

}

int zamjenaCifara(int br) {

	//123

	int novi = 0, temp = 0, potencija = 0;
	while (br > 0) {

		temp = br % 10;
		if (temp % 2 == 0) {

			novi += 5 * pow(10, potencija);
		}
		else 
		{
		
			novi += temp * pow(10, potencija);

		}
		br /= 10;
		potencija++;
	}


	return novi;
}
