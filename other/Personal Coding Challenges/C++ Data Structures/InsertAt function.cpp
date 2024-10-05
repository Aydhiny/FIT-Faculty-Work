#include <iostream>

using namespace std;
struct Node* head;
struct Node
{
	int data;
	struct Node* next;
};
void InsertAt(int data, int n) 
{
	Node* temp1 = new Node();
	temp1->data = data;
	temp1->next = nullptr;
	if(n == 1)
	{
		temp1->next = head;
		head = temp1;
		return;
	}
	Node* temp2 = head;
	for (int i = 0; i < n - 2; i++)
	{
		temp2 = temp2->next;
	}
	temp1->next = temp2->next;
	temp2->next = temp1;
}
void Print() 
{
	Node* temp = head;
	while(temp != nullptr) 
	{
		cout << temp->data << " , ";
		temp = temp->next;
	}
	cout << endl;
}
int main() 
{
	head = nullptr;
	InsertAt(2, 1); //List: 2
	InsertAt(3, 2); //List: 2, 3
	InsertAt(4, 1); //List: 4, 2, 3
	InsertAt(5, 2); //List: 4, 5, 2, 3 
	Print();
	return 0;
}