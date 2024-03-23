#include <iostream>

using namespace std;
struct Node* head;
struct Node 
{
	int data;
	struct Node* next;
	struct Node* prev;
};
struct Node* GetNewNode(int x) 
{
	//LOCAL TO GETNEWNODE
	struct Node* newNode = new Node();
	newNode->data = x;
	newNode->prev = NULL;
	newNode->next = NULL;
	return newNode;
}
void InsertAtHead(int x) 
{
	//LOCAL TO INSERTATHEAD
	struct Node* newNode = GetNewNode(x);
	if(head == NULL) 
	{
		head = newNode;
		return;
	}
	head->prev = newNode;
	newNode->next = head;
	head = newNode;
}
void Print() 
{
	struct Node* temp = head;
	cout << "Forward: " << endl;
	while(temp != NULL) 
	{
		cout << temp->data << ",";
		temp = temp->next;
	}
	cout << endl;
}
void ReversePrint() 
{
	struct Node* temp = head;
	if (temp == NULL) return; //if empty list.
	//Going to last Node
	while(temp->next != NULL) 
	{
		temp = temp->next;
	}
	//Traversing backwards using prev.
	cout << "Reverse: " << endl;
	while(temp != NULL) 
	{
		cout << temp->data << ",";
		temp = temp->prev;
	}
	cout << endl;
}
int main() 
{ 
	head = NULL;
	InsertAtHead(2); Print(); ReversePrint();
	InsertAtHead(4); Print(); ReversePrint();
	InsertAtHead(6); Print(); ReversePrint();
	return 0;
}