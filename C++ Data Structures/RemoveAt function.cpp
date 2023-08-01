#include <iostream>

using namespace std;

struct Node* head;
struct Node {
	int data;
	struct Node* next;
};
void Insert(int data) 
{
	struct Node* newNode = new Node(); // Create a new node
	newNode->data = data;
	newNode->next = nullptr;

	if (head == nullptr) {
		// If the list is empty, make the new node the head
		head = newNode;
	}
	else {
		// Traverse the list to the last node
		struct Node* temp = head;
		while (temp->next != nullptr) {
			temp = temp->next;
		}
		// Insert the new node at the end
		temp->next = newNode;
	}
}
void Print()
{
	struct Node* temp = head;
	cout << "List: ";
	while (temp != nullptr) {
		cout << temp->data << " ";
		temp = temp->next;
	}
	cout << endl;
}
void Remove(int n) 
{
	struct Node* temp1 = head;
	if(n == 1) 
	{
		head = temp1->next; //head now points to second node.
		delete temp1;
		return;
	}
	for (int i = 0; i < n - 2; i++)
	{
		temp1 = temp1->next;
		//temp1 points to (n-1)th Node.
	}
	struct Node* temp2 = temp1->next; //nth Node
	temp1->next = temp2->next; //(n+1)nth Node
	delete (temp2);
}
int main() 
{
	head = nullptr; // empty list
	Insert(2);
	Insert(4);
	Insert(6);
	Insert(5); // List: 2,4,6,5
	Print();
	int n;
	cout << "Unesite poziciju: " << endl;
	cin >> n;
	Remove(n);
	Print();
	return 0;
}