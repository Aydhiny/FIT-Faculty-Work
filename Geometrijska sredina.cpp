#include <iostream>

using namespace std;

int main() {

	int n;
	cout << "Ünesite vrijednost n: " << endl;
	cin >> n;

	if (n % 5 != 0 && n % 2 != 0) {
		for (int i = 1; i <= n; i+=2) 
			cout << n << endl;
	
	}
	return 0;
}