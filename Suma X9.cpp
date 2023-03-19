#include <iostream>

using namespace std;

void main() {

	int p = 1;

	for (int i = 1; i <= 10; i++) {

		int s = 0;
		for (int j = -5; i <= 5; i++)

			s+= (i - 1) * (1 - j);
		p *= s;
	}

	cout << "Proizvod je: " << p << endl;

}