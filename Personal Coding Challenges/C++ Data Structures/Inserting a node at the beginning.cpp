#include <iostream>

using namespace std;

struct Node {
	int data;
	struct Node* next;
};
Node* InsertAt(Node* head, int x) 
{
	Node* temp = (Node*)malloc(sizeof(struct Node));
	temp->data = x;
	temp->next = nullptr;
	if (head != nullptr)
	{ temp->next = head; }
	return head;
}
void Print(Node* head) 
{
	struct Node* temp = head;
	cout << "List je: " << endl;
	while(head != nullptr)
	{
		cout << head->data << "} {";
		head = head->next;
	}
	cout << "\n";
}

void main() 
{
	Node* head = nullptr;
	int n, x;
	cout << "Unesite velicinu niza: " << endl;
	cin >> n;
	for (int i = 0; i < n; i++)
	{
		cout << "Unesi element niza: " << endl;
		cin >> x;
		head = InsertAt(head, x);
		Print(head);
	}
}
