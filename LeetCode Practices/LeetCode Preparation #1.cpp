#include <iostream>
#include <vector>
const char* crt = "----------------------------\n";
using namespace std;

ostream& operator<<(ostream& COUT, const vector<int>& obj) 
{
	for (size_t i = 0; i < obj.size(); i++)
	{
		COUT << obj[i] << " | ";
	}
	COUT << endl;
	return COUT;
}
vector<int> NapraviVektor(int vel) 
{
	vector <int> vec1;
	vec1.resize(vel);
	for (size_t i = 0; i < vel; i++)
	{
		cout << "Unesi: " << i + 1 << " element vektora: ";
		cin >> vec1[i];
	}
	return vec1;
}
int main() 
{
	//REMOVE DUPLICATES

	vector <int> dup = {1, 1, 2, 2, 3, 3, 4, 5, 6, 7};
	for (size_t i = 0; i < dup.size() - 1; i++)
	{
		if (dup[i] == dup[i + 1])
			dup.erase(dup.begin() + i);
	}
	cout << crt << "Vektor poslije sorta bez duplikata: " << dup << endl;

	// FIND MAX ELEMENT IN VECTOR

	vector <int> find = {1, 50, 43, 67, 24, 3};
	int max = 0;
	for (size_t i = 0; i < find.size(); i++)
	{
		if (max < find[i])
			max = find[i];
	}
	cout << crt << "Max element u nizu je: " << max << endl;

	//INTERSECTION OF TWO VECTORS

	int size;
	cout << "Unesite velicinu vektora: " << endl;
	cin >> size;
	vector<int> v1 = NapraviVektor(size);
	int size2;
	cout << "Unesite velicinu vektora: " << endl;
	cin >> size2;
	cout << crt << "Vektor 2: " << endl;
	vector<int> v2 = NapraviVektor(size2);
	for (size_t i = 0; i < size; i++)
	{
		if (v1[i] == v2[i])
			v1.erase(v1.begin() + i);
		if (v2[i] == size - 1)
			break;
	}
	cout << v1 << endl;

	return 0;
}