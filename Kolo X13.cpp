#include <iostream>

using namespace std;

void main() {

	int u1 = 0;
	int u2 = 0;
	int u3 = 0;

	for (u1 = 0; u1 <= 1; u1++)
		for (u2 = 0; u2 <= 1; u2++)
			for (u3 = 0; u3 <= 1; u3++)

				cout << u1 << " " << u2 << " " << u3 << " " << "(XOR) " << (u1 ^ u2 ^ u3) << endl;

}