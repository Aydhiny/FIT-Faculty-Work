#include <iostream>
#include <string>
#include <vector>

/* Jacobsthal Sekvenca
Opis: Jacobsthal sekvenca koristi formulu 
J(n)=J(n−1)+2×J(n−2).
Početni brojevi: 0, 1
Primer: 0, 1, 1, 3, 5, 11, 21, ...
Zadatak: Napiši funkciju koja vraća 
𝑛
n-ti broj u Jacobsthal sekvenci
*/

using namespace std;

const char* strjelica = "\n-------------------\n";

int main() 
{
	int broj;
	vector<int> niz;
	niz.push_back(0);
	niz.push_back(1);
	cout << strjelica << "Unesite razinu do koje idemo unutar Jacobsthal sekvence: " << strjelica;
	cin >> broj;
	for(int i = 2; i < broj; i++)
	{
		niz.push_back(niz[i - 1] + 2 * (niz[i - 2]));
	}
	for(int i = 0; i < niz.size(); i++) 
	{
		cout << niz[i] << " | ";
	}
	cout << strjelica;
	return 0;
}