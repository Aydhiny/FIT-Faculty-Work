#include<iostream>
using namespace std;

class tacka2D {
public:
	int x, y;
	tacka2D(int x = 0, int y = 0) {
		this->x = x;
		this->y = y;
	}
	friend ostream& operator<<(ostream& cout, tacka2D& tacka) {
		cout << "(" << tacka.x << "," << tacka.y << ")" << endl;
		return cout;
	}
};

typedef tacka2D Tip;

class prioritetniRedSEK {
	int vel_niza;
	int trenutno;
	Tip* niz;
	void prosiriNiz() {
		vel_niza *= vel_niza;
		Tip* temp = new Tip[vel_niza];
		for (size_t i = 0; i < trenutno; i++){
			temp[i] = niz[i];
		}
		delete niz;
		niz = temp;
	}
	int izracunajDistancu(int indeks) {
		return sqrt((pow(5 - niz[indeks].x, 2) + pow(5 - niz[indeks].y, 2)));
	}
public:
	prioritetniRedSEK(int vel_niza = 10) {
		this->vel_niza = vel_niza;
		trenutno = 0;
		niz = new Tip[vel_niza];
	}
	void dodaj(Tip x) {
		if (jel_pun())
			prosiriNiz();
		niz[trenutno] = x;
		trenutno++;
	}
	Tip ukloni() {
		if (jel_prazan())
			return Tip();
		int minDistanca = INT_MAX;
		int minIndeks = -1;
		for (size_t i = 0; i < trenutno; i++){
			int distanca = izracunajDistancu(i);
			if (distanca < minDistanca) {
				minDistanca = distanca;
				minIndeks = i;
			}
		}
		tacka2D out = niz[minIndeks];
		trenutno--;
		niz[minIndeks] = niz[trenutno];
		return out;
	}
	bool jel_pun() {
		return trenutno == vel_niza;
	}
	bool jel_prazan() {
		return trenutno == 0;
	}
	void print() {
		for (size_t i = 0; i < trenutno; i++)
		{
			cout << niz[i];
		}
		cout << endl;
	}
};

void main() {
	tacka2D tacka1(1, 2);
	tacka2D tacka2(2, 3);
	tacka2D tacka3(3, 4);
	tacka2D tacka4(4, 5);
	tacka2D tacka5(5, 6);
	prioritetniRedSEK red;
	red.dodaj(tacka1);
	red.dodaj(tacka2);
	red.dodaj(tacka3);
	red.dodaj(tacka4);
	red.dodaj(tacka5);
	red.print();
	tacka2D uklonjena = red.ukloni();
	cout << "Uklonjena tacka " << uklonjena << endl;
}