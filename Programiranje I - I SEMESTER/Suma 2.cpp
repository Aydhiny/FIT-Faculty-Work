#include <iostream>

using namespace std;

void main() {

	int s = 0;

	for (int u = 1; u <= 5; u++) 
	{

	int faktorijel = 1;
		for (int u1 = 1; u1 <= u; u1++)
			faktorijel *= u1;
			s += faktorijel;
	}
	cout << "SUMA JE " << s << endl;;
}