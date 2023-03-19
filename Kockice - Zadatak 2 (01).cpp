#include <iostream>
#include <ctime>
#include <cstdlib>

using namespace std;
int randKockice() {
	int broj_bacanja = 0;
	int broj_istih = 0;
	do
	{
		int kockica1 = rand() % 6 + 1;
		int kockica2 = rand() % 6 + 1;
		int kockica3 = rand() % 6 + 1;

		if (kockica1 == kockica2 && kockica2 == kockica3) {
			broj_istih++;
		}
		else {
			broj_istih = 0;
		}
		broj_bacanja++;
	} while (broj_istih < 2);
	return broj_bacanja;
}

int main() {
	srand(time(NULL));
	cout << "Tri ista broja dobila su se dva puta uzastopno nakon " << randKockice() << " bacanja" << endl;
	return 0;
}
