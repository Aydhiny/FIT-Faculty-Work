#include <iostream>
#include <cmath>

using namespace std;

int main() {

	float GS = 1.0;
	float n;
	int brojac = 0;
	cout << "Unesite vrijednost n: " << endl;
	cin >> n;
	for (int i = 1; i <= n; i+= 2) {

		if (i % 5 != 0) {
			GS *= i;
			brojac++;
			cout << pow(GS, 1 / double(brojac)) << endl;

		}
		
	}
	return 0;
}