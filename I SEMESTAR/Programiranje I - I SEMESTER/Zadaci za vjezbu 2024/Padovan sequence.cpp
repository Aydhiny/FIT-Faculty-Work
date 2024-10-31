#include <iostream>
#include <string>
#include <vector>

/* P(n)=P(n−2)+P(n−3) */

/* Padovan Sekvenca
Opis: Padovan sekvenca se formira tako da je svaki broj zbir prethodna dva broja u nizu, ali sa preskočenim jednim brojem između.
Pravila: 
P(n)=P(n−2)+P(n−3)
Početni brojevi: 1, 1, 1
Primer: 1, 1, 1, 2, 2, 3, 4, 5, ...
Zadatak: Napiši funkciju koja vraća 
𝑛
n-ti broj u Padovan sekvenci.*/

using namespace std;

const char* strjelica = "\n-------------------\n";

int main() 
{
	int broj;
	cout << strjelica << "Padovan sekvenca!" << strjelica;
	vector<int> niz;
	niz.push_back(1);
	niz.push_back(1);
	niz.push_back(1);
	cout << "Unesite broj do kojeg cemo proci kroz padovan sekvencu: " << endl;
	cin >> broj;
	for(int i = 3; i < broj; i++)
	{
		niz.push_back((niz[i - 2]) + (niz[i - 3]));
	}
	cout << strjelica << "Insertovanje izvrseno, vas niz: " << endl;
	for(int i = 0; i < niz.size(); i++) 
	{
		cout << niz[i] << " | ";
	}
	cout << strjelica;
	// [1, 1, 1]
	// [1, 1, 1, 2, 2, 3, 4, 5, 7]
	//Easter egg hunter mouse 2 lol
	return 0;
}