#include <iostream>

using namespace std;

bool jeRastuci(int br)  
{
	while (br >= 10) 
	{
		int temp = br % 10;
		int temp2 = (br / 10) % 10;
		if (temp >= temp2)
			return false;
		br /= 10;
	}
	return true;
}
int main() 
{
	int n;
	cout << "Unesite broj n: " << endl;
	cin >> n;

	for (int i = 0; i < n; i++) 
	{
		if (jeRastuci(i))
			cout << i << endl;
	}


}
