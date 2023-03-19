#include <iostream>

using namespace std;

int reccurPower(int k, int l);
int main() 
{
	int n;
	int k = 2, l = 2;
	cout << "Unesite prirodan broj n: " << endl;
	cin >> n;
	int m = n;

	bool flag = true;
	while(flag) 
	{
		int potencija = reccurPower(k, l);
		if (potencija < m)
			l++;
		else if (sqrt(m) + 1 < k)
		{
			m++; k = 2; l = 2;
		}
		else if (potencija > m)
		{
			k++; l = 2;
		}
		else
			flag = false;
	}
	cout << "Najmanji prirodan broj: " << k << "^" << l << "=" << reccurPower(k, l) << endl;
}
int reccurPower(int k, int l) 
{
	if (l == 1) return k;
	return k * reccurPower(k, l - 1);
}