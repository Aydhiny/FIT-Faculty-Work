
#include <iostream>
using namespace std;
#include <exception>
#include <cmath>

struct Tacka2D
{

	int x;
	int y;

	Tacka2D(int x = 0, int y = 0) {
		this->x = x;
		this->y = y;
	}

	friend ostream& operator<<(ostream& COUT, const Tacka2D& t) {
		COUT << "t(" << t.x << "," << t.y << ")";
		return COUT;
	}

};

template <class Tip>
struct Cvor
{
	Cvor* next;
	Tip info;

	Cvor(Tip info, Cvor<Tip>* next) : info(info)
	{
		this->next = next;
	}
};

template <class Tip>
class ListaPov
{
private:
	int brojac;
	Cvor<Tip>* prvi;
public:
	ListaPov()
	{
		brojac = 0;
		prvi = nullptr;
	}

	void dodaj(Tip v)
	{
		Cvor<Tip>* t = new Cvor<Tip>(v, prvi);
		prvi = t;
		brojac++;
	}

	Tip ukloni()
	{
		if (isPrazan())
			throw std::exception("Greska. Nije moguce ukloniti elemenat iz prazne liste");

		brojac--;
		Cvor<Tip>* t = prvi;
		prvi = prvi->next;
		Tip x = t->info;
		delete t;
		return x;
	}




	bool isPrazan()
	{
		return (prvi == nullptr);
	}

	int count()
	{
		return brojac;
	}

	void print(string pre = "", string post = ", ")
	{
		Cvor<Tip>* t = prvi;
		while (t != nullptr)
		{
			cout << pre << t->info << post;
			t = t->next;
		}
		cout << endl;
	}

	Tip& get(int i)
	{
		if (i > brojac)
			throw std::exception("indeks je veći od brojaca");

		Cvor<Tip>* t = prvi;
		for (int j = 0; j < (brojac - i - 1); j++)
		{
			t = t->next;
		}
		return t->info;
	}

	Tip& operator[](int i)
	{
		return get(i);
	}

	void set(int i, Tip v)
	{
		get(i) = v;
	}

	bool sadrzi(Tip v)
	{
		Cvor<Tip>* t = prvi;
		while (t != nullptr)
		{
			if (t->info == v)
				return true;
			t = t->next;
		}
		return false;
	}

	Tip* formirajNiz()
	{
		Tip* niz = new Tip[this->brojac];

		int b = 0;
		Cvor<Tip>* t = prvi;
		while (t != nullptr)
		{
			niz[b++] = t->info;
			t = t->next;
		}
		return niz;
	}
};

class Hesiranje
{

	int brojac = 0;
	int velicinaNiza = 10;
	ListaPov<Tacka2D>* niz;

	int funkcija(Tacka2D t) {
		return (int)sqrt(pow(t.x + t.y, 2) / 2) % velicinaNiza;
	}

public:

	Hesiranje() {
		brojac = 0;
		niz = new ListaPov<Tacka2D>[velicinaNiza];
	}
	~Hesiranje() = default;
	void Add(Tacka2D t) {
		if (velicinaNiza == brojac) {
			throw exception("Niz je pun");
		}
		auto index = funkcija(t);
		niz[index].dodaj(t);
		brojac++;
	}

	void Remove(Tacka2D t) {
		if (brojac == 0) {
			throw exception("Niz je prazan");
		}
		auto index = funkcija(t);
		niz[index].ukloni();
	}

	void Print() {
		for (int i = 0; i < velicinaNiza; i++)
		{
			cout << "Lista " << i << ": ";
			niz[i].print();
		}
	}
};

void main()
{
	Tacka2D t1(1, 4);
	Tacka2D t2(8, 4);
	Tacka2D t3(16, 32);
	Tacka2D t4(2, 8);
	cout << "--------------------" << endl;

	cout << "Dodaj: " << endl;

	Hesiranje hes;
	hes.Add(t1);
	hes.Add(t2);
	hes.Add(t3);
	hes.Add(t4);
	hes.Print();

	cout << "----------------------------" << endl;

	cout << "Ukloni: " << endl;

	hes.Remove(t1);
	hes.Remove(t2);
	//hes.Remove(t3);
	//hes.Remove(t4);
	hes.Print();


	system("pause");
}