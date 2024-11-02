#include <iostream>
#include <sstream>
#include <string>
#include <vector>
/* URADJENO Napiši funkciju koja prima jedan string kao ulaz i koristi stringstream za izdvajanje svake reči iz stringa. Funkcija bi trebalo da vrati vektor reči.
*/

/*URADJENO Napiši funkciju koja prima string u CSV formatu (gde su elementi razdvojeni zarezima) i koristi stringstream da podeli string na delove i smesti ih u vektor.
 */

/* URADJENO Napiši funkciju koja prima string brojeva razdvojenih razmacima i vraća vektor celih brojeva. Koristi stringstream za konverziju svakog broja u int*/

/*URADJENO Napiši funkciju koja prima ime, godine i grad kao ulazne podatke, koristi stringstream za kreiranje formatisanog stringa u formatu:

arduino
Copy code
"Ime: [ime], Godine: [godine], Grad: [grad]

std::string ime = "Ayden";
int godine = 21;
std::string grad = "Sarajevo";
Očekivani izlaz:

arduino
Copy code
"Ime: Ayden, Godine: 21, Grad: Sarajevo""
*/

/* Napiši funkciju koja prima string i koristi stringstream za brojanje reči u stringu. Funkcija treba da vrati broj reči.*/
using namespace std;

const char* strjelica = "\n-------------------\n";



int brojanjeRijeci(string rijec) 
{
	int broj = 0;
	stringstream ss(rijec);
	while (ss >> rijec)
		broj++;
	return broj;
}

string Formatisanje(string ime, int godine, string grad) 
{
	stringstream ss;
	ss << "Ime: " << ime << "\nGodine: " << godine << "\nGrad: " << grad;
	return ss.str();
}

int saberiBrojeve(const string& numbers) 
{
	int broj, suma = 0;
	stringstream saberi(numbers);
	while (saberi >> broj)
		suma += broj;
	return suma;
}

vector<int> konverzija(const string& StrBr) 
{
	vector<int> mojVektor;
	int tempBr;
	stringstream ss(StrBr);
	while (ss >> tempBr)
		mojVektor.push_back(tempBr);
	return mojVektor;
}

int main() 
{
	string text = "Ayden,21,Student";
	stringstream ss;
	ss << text;
	vector<string> izlaz;
	while(getline(ss, text, ';')) 
	{
		izlaz.push_back(text);
	}
	cout << "[";
	for(int i = 0; i < izlaz.size(); i++) 
	{
		if (i > 0 && i < izlaz.size())
			cout << ",";
		cout << "'" << izlaz[i] << "'";
	}
	cout << "]";
	cout << strjelica;
	cout << saberiBrojeve("10 20 30 40 50");
	cout << strjelica;
	vector<int> Vektor = konverzija("1 2 3 4 5 6");
	for (int i = 0; i < Vektor.size(); i++)
	{
		if (i > 0 && i < Vektor.size())
			cout << ",";
		cout << "'" << Vektor[i] << "'";
	}
	cout << strjelica;
	cout << Formatisanje("Ajdin", 21, "Kakanj");
	cout << strjelica << brojanjeRijeci("C++ je moćan programski jezik");

	return 0;
}