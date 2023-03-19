#include <iostream>

using namespace std;

void main() {


	float s = 0.0f;


	for (int i = -10; i <= 10; i++) {

		s += pow(i, 2);

	}
		for (int i = -5; i <= 5; i++) {

			s += i;
		}

		s += 1 / sqrt(5);

		cout << "Rezultat je BEGI: " << s << endl;




}