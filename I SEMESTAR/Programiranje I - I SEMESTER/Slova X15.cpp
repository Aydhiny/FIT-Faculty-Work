#include <iostream>

using namespace std;

void main() {

	char slovo = 'a';

	for (int i = 1; i <= 20; i+2) {

		slovo += i;

		cout << slovo;
	}
		cout << "a ";

}

char odAdoZ(char slovo) {

	if (slovo == 'Z') return 'A';
	if (slovo == 'z') return 'a';
	return slovo;
}