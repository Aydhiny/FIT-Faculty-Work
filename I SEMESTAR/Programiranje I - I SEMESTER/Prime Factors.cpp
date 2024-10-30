#include <iostream>
#include <string>

using namespace std;

const int vel = 10;

bool isPrime(int n) 
{
	// Just for show
	if (n == 1) return false;
	for(int i = 2; i < n; i++) 
	{
		if (n % i == 0)
			return false;
	}
	return true;
}
int main() 
{
	int broj = 36;
	int faktor1 = 1;
	int temporarni = 2;
	for(int i = 2; i <= broj; i++) 
	{
		while (broj % i == 0) {
			cout << i << " ";
			broj /= i;
		}
	}
	return 0;
}