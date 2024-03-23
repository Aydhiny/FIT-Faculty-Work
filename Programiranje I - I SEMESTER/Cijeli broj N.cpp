#include <iostream>
#include <cmath>

using namespace std;

float unosN();
float Gs1(float);

float unosN() {

	float N;
	cout << "Unesite vrijednost N: " << endl;
	cin >> N;

	return N;
}

float Gs1(float N) {

	float Gs;

	for (int i = 1; i <= N; i++) {

		if (i % 2 == 0) {
			if (i % 5 == 0)
				Gs = pow(i * N, 1 / N);
		}
	}
	return Gs;
}

int main() {

	float N = unosN();
	float Gs = Gs1(N);
	cout << "Vas rezultat je = " << Gs << endl;

	return 0;
}