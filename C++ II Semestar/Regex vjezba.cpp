#include <iostream>
#include <string>
#include <regex>
using namespace std;

bool jeValidanPassword(const string& brojevi) 
{
	regex regexProba(R"([*_]\d[a-z]( ?)[A-Z]\d[a-z])");
	return regex_match(brojevi, regexProba);
}
bool jevalidanEmail(const string& email) 
{
	/*
	email adresa mora biti u formatu: text@outlook.com ili text@edu.fit.ba
	u slucaju da email adresa nije validna, postaviti je na defaultnu: notSet@edu.fit.ba
	za provjeru koristiti regex
	*/
	regex emailProba(R"([A-Za-z]+@(outlook.com|edu.fit.ba))");
	return regex_match(email, emailProba);
}
void main() 
{
	if (jevalidanEmail("ajdinibits@outlook.com"))
		cout << "Email je validan!" << endl;
	else
		cout << "Nije validan!" << endl;

	string password = "*_0gT9q";

	if (jeValidanPassword(password))
		cout << "Password uspjesno unesen" << endl;
	else
		cout << "Netacan password" << endl;
}

