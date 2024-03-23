#include <iostream>

int main() {

	int a;

	std::cout << "Unesite broj" << std::endl;
	std::cin >> a;

	if (a / 2 == 0) {


		std::cout << "Broj je paran" << std::endl;
	}
	else {
		std::cout << "Broj je neparan" << std::endl;
	}

	return 0;
}