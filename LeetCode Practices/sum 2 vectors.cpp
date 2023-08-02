#include <iostream>
#include <vector>
const char* crt = "-------------------------------\n";

using namespace std;

void Ispis(vector<int>& v) 
{
	for (size_t i = 0; i < v.size(); i++)
	{
		cout << v[i] << " | ";
	}
	cout << endl;
}
int main() 
{
	vector <int> v1 = {1,2,3,4,5,6,10};
	vector <int> v2 = {4,6,8,3,1,2,25};
	cout << "Ispisi vektora: " << endl;
	Ispis(v1);
	Ispis(v2);
	cout << crt << "Suma vektora: " << endl;

	if(v1.size() > v2.size()) 
	{
		for (size_t i = 0; i < v1.size(); i++)
		{
			v1[i] += v2[i];
		}
	}
	else {
		for (size_t i = 0; i < v2.size(); i++)
		{
			v1[i] += v2[i];
		}
	}
	Ispis(v1);
	cout << crt << endl;

	return 0;
}
