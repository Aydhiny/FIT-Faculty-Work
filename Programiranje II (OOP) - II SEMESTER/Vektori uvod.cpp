#include <iostream>
#include <vector>
#include <ctime>
#include<algorithm>
using namespace std;

void main() 
{
	vector <int> vec1{ 1, 5, 6, 7, 9 };
	random_shuffle(vec1.begin(), vec1.end());
	for (int i = 0; i < vec1.size(); i++)
	{
		cout << vec1[i] << "|";
	}
	cout << endl;

	vector <int> onetoTen{ 1, 2, 3, 4 ,5 , 6, 7 ,8 ,9, 10 };
	onetoTen.erase(remove_if(onetoTen.begin(), onetoTen.end(),
		[](int x) {return x % 2 == 0; }), onetoTen.end());
	

	for (int i = 0; i < onetoTen.size(); i++)
	{
		cout << onetoTen[i] << "|";
	}
	cout << endl;
	vector <int> rotate1{ 1 , 2 , 3 , 4 , 5 };
}
