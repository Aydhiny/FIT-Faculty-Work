#include <iostream>

using namespace std;

struct Node
{
	int data;
	struct Node* next;
};

struct Node* head;

struct Node* Reverse(struct Node* head)
{
	struct Node* current, * prev, * next;
	current = head;
	prev = NULL;
	while (current != NULL)
	{
		next = current->next;
		current->next = prev;
		prev = current;
		current = next;
	}
	head = prev;
	return head;
}

struct Node* InsertAt(struct Node* head, int data, int n)
{
	struct Node* temp1 = new Node();
	temp1->data = data;
	temp1->next = nullptr;

	if (n == 1)
	{
		temp1->next = head;
		head = temp1;
		return head;
	}

	struct Node* temp2 = head;
	for (int i = 0; i < n - 2; i++)
	{
		temp2 = temp2->next;
	}

	temp1->next = temp2->next;
	temp2->next = temp1;
	return head;
}

void Print()
{
	struct Node* temp = head;
	while (temp != nullptr)
	{
		cout << temp->data << " , ";
		temp = temp->next;
	}
	cout << endl;
}

int main()
{
	head = NULL;
	head = InsertAt(head, 2, 1);
	head = InsertAt(head, 4, 2);
	head = InsertAt(head, 6, 3);
	head = InsertAt(head, 8, 4);
	Print();
	head = Reverse(head);
	Print();
	return 0;
}


