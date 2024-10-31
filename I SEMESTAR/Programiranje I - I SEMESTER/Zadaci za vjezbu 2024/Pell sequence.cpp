#include <iostream>
#include <string>
#include <vector>

/* Opis: Pell sekvenca je definisana sa formulom 
P(n)=2×P(n−1)+P(n−2).
Početni brojevi: 0, 1
Primer: 0, 1, 2, 5, 12, 29, 70, ...
Zadatak: Napiši funkciju koja vraća 
𝑛
n-ti broj u Pell sekvenci.
*/

using namespace std;

const char* strjelica = "\n-------------------\n";

int main() 
{
	int broj;
	vector<int> niz;
	niz.push_back(0);
	niz.push_back(1);
	cout << strjelica << "Unesite razinu do koje idemo unutar Pell sekvence: " << strjelica;
	cin >> broj;
	for(int i = 2; i < broj; i++)
	{
		niz.push_back(2 * (niz[i - 1]) + niz[i - 2]);
	}
	for(int i = 0; i < niz.size(); i++) 
	{
		cout << niz[i] << " | ";
	}
	cout << strjelica;
	return 0;
}