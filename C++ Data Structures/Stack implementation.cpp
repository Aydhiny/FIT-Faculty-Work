#include <iostream>
#define MAX_SIZE 101
using namespace std;
int A[MAX_SIZE];
int top = -1;
void Push(int x) 
{
	if (top == MAX_SIZE - 1) 
	{
		cout << "Error: stack overflow\n";
		return;
	}
	A[++top] = x;
}
void Pop() 
{
	if(top == -1)
	{
		cout << "Error: No element to pop\n";
		return;
	}
	top--;
}
int Top() 
{
	return A[top];
}
void Print() 
{
	cout << "Stack: ";
	for (int i = 0; i <= top; i++)
	{
		cout << A[i] << ",";
	}
	cout << "\n";
}
int main() 
{
	Push(2); Print();
	Push(5); Print();
	Push(10); Print();
	Pop(); Print();
	Push(12); Print();

	return 0;
}