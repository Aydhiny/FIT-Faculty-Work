#include <iostream>
#include <string>
#include <cmath>
#include <vector>

/* Šteta od Puževa
Opis: Zamislimo sekvencu u kojoj svaki naredni broj predstavlja ukupnu štetu nanesenu vrtu puževima, a šteta svakog puža povećava se kao u eksponencijalnom rastu. 
Definiši funkciju koja izračunava ukupnu štetu posle 
n dana, gde je šteta dana 
n jednaka zbiru štete prethodnog i dvojnog prethodnog dana.
Početni uslovi: 1, 3
Primer: 1, 3, 7, 17, 41, ...
Zadatak: Napiši funkciju koja vraća štetu za 
𝑛
n-ti dan.
*/

using namespace std;

const char* strjelica = "\n-------------------\n";

int main() 
{
	int broj;
	vector<int> niz;
	niz.push_back(1);
	niz.push_back(3);
	vector<int> copy;
	copy.push_back(1);
	copy.push_back(3);
	cout << strjelica << "Unesite razinu do koje provjeravamo štetu od puževa: " << strjelica;
	cin >> broj;

	for (int i = 2; i < broj; i++) 
	{
		copy.push_back(copy[i - 1] + copy[i - 2]);
	}
	for(int i = 2; i < broj; i++) 
	{
		niz.push_back(copy.front() * pow(1 + i, broj));
	}

	for (int i = 0; i < niz.size(); i++) 
	{
		cout << niz[i] << " | ";
	}

	cout << strjelica;
	return 0;
}