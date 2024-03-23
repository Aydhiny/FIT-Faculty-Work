#include <iostream>

using namespace std;

void main() {


	int n;
	do {
		cout << "Unesite neku cifru: " << endl;
		cin >> n;
	}
		while (n < 0);

	

}
int ZamjenaCifara(int br) {

	// 123 = 153
	int novi = 0;
	int zadnjacifra = 0;
	int potencija = 0;
	while (br > 0) 
	{
		zadnjacifra = br % 10;
		if (zadnjacifra % 2 == 0) 
		{
			novi += 5 * pow(10, potencija);
		}
	}
}