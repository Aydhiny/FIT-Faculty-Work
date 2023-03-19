#include <iostream>

using namespace std;

const int vel = 100;
void dodajFibonaccija(int, int&);
long long int Fibonacci(long long int);
bool jeProst(int);
int main() 
{
	int suma = 0;
	for (int i = 0; i < vel; i++) 
	{
		dodajFibonaccija(i, suma);
	}
	cout << "Suma prvih 100 elemenata Fiba iznosi: " << suma << endl;


	return 0;
}

long long int Fibonacci(int br) 
{
	long long int prvi = 0, drugi = 1, fibonacci = 0;
	for(int i = 0; i < br; i++) 
	{
		fibonacci = prvi + drugi;
		prvi = drugi;
		drugi = fibonacci;
	}
	return fibonacci;
}

bool jeProst(int br)
{
	if (br == 1 || br == 0)
		return false;
	for (int i = 2; i < br; i++)
	{
		if (br % i == 0)
			return false;
	}
	return true;
}

int faktorijel(int br) 
{
	int F = 1;
	for (int i = 1; i <= br; i++)
		F *= i;
	return F;
}
void dodajFibonaccija(int br, int& suma) 
{
	int broj = Fibonacci(br);
	if (jeProst(broj))
		suma += faktorijel(broj);
}