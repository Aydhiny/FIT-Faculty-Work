#include <iostream>

using namespace std;

struct figura 
{
	int ID;
	char* nazivFigure;
	float* visinaFigure;

	figura() 
	{
		ID = 0;
		nazivFigure = new char[20];
		visinaFigure = new float;
	}
	~figura() 
	{
		delete[] nazivFigure;
		nazivFigure = nullptr;
		delete visinaFigure;
		visinaFigure = nullptr;
	}

};

int main() 
{
	int red, kolona;
	cout << "Unesite broj redova: " << endl;
	cin >> red;

	cout << "Unesite broj kolona: " << endl;
	cin >> kolona;






}