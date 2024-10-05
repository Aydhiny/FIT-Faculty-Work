#include <iostream>
#include <stack>
using namespace std;
void Reverse(char *C, int n) 
{
	stack<char> S;
	for (size_t i = 0; i < n - 1; i++)
	{
		S.push(C[i]);
	}
	for (size_t i = 0; i < n - 1; i++)
	{
		C[i] = S.top();
		S.pop();
	}
}
int main() 
{
	char c[51];
	cout << "Enter a string: " << endl;
	cin >> c;
	Reverse(c, strlen(c));
	cout << "Output: " << c << endl;
	return 0;
}