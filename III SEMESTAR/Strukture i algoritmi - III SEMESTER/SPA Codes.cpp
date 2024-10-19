#include<iostream>

#pragma region CVOR
template<class T>
struct Cvor {
	Cvor* next;
	T info;
	Cvor() {}
	Cvor(T info, Cvor<T>* next) {
		this->info = info;
		this->next = next;
	}
};
template<class T>
bool operator == (T el1, T el2) {
	return el1 == el2;
}
template<class T>
bool operator > (T el1, T el2) {
	return el1 > el2;
}
template<class T>
bool operator < (T el1, T el2) {
	return el1 < el2;
}
#pragma endregion

#pragma region RED
#pragma region RED POV

template<typename T>
class RedPov {
private:
	Cvor<T>* pocetak;
	Cvor<T>* kraj;
public:
	RedPov() {
		pocetak = nullptr;
		kraj = nullptr;
	}
	void dodaj(T value) { // DODAVANJE NA KRAJ
		Cvor<T>* temp = new Cvor<T>(value, nullptr);
		if (!isPrazan()) {
			kraj->next = temp;
			kraj = temp;
		}
		else kraj = pocetak = temp;
	}
	T ukloni() { // UKLANJANJE SA POCETKA
		if (isPrazan())
			throw std::exception("Prazan red!");

		Cvor<T>* temp = pocetak;
		pocetak = pocetak->next;

		if (pocetak == nullptr) kraj = nullptr;

		T info = temp->info;
		delete temp;
		return info;
	}
	bool isPrazan() {
		return pocetak == nullptr;
	}
	void print(std::string pre = "", std::string post = ", ") {
		Cvor<T>* temp = pocetak;
		while (temp != nullptr)
		{
			std::cout << pre << temp->info << post;
			temp = temp->next;
		}
		std::cout << std::endl;
	}
	bool sadrzi(T value) {
		Cvor<T>* temp = pocetak;
		while (temp != nullptr)
		{
			if (temp->info == value)
				return true;
		}
		return false;
	}
};
#pragma endregion
#pragma region RED SEKV

template<class T>
class RedSkev {
private:
	int max, pocetak, kraj, brojac;
	T* niz;
	void prosiriRed() {
		int newMax = max * 2;
		T* newNiz = new T[newMax];
		int newPocetak = 0; int oldPocetak = pocetak;

		while (newPocetak < brojac) {
			newNiz[newPocetak++] = niz[oldPocetak++];
			if (oldPocetak == max) oldPocetak = 0;
		}

		max = newMax;
		delete[] niz;
		niz = newNiz;
		pocetak = 0; kraj = brojac;
	}
public:
	RedSkev(int max = 10) {
		brojac = pocetak = kraj = 0;
		this->max = max;
		niz = new T[max];
	}
	void dodaj(T value) { // DODAVANJE NA KRAJ
		if (brojac == max) prosiriRed();
		brojac++;
		niz[kraj++] = value;
		if (kraj == max) kraj = 0;
	}
	T ukloni() { // UKLANJANJE SA POCETKA
		if (isPrazan()) throw std::exception("Prazan red!");
		brojac--;
		T info = niz[pocetak++];
		if (pocetak == max) pocetak = 0;
		return info;
	}
	bool isPrazan() {
		return brojac == 0;
	}
	void print(std::string pre = "", std::string post = ", ") {
		int i = pocetak;
		int b = 0;
		while (b++ < brojac)
		{
			std::cout << pre << niz[i++] << post;
			if (i == max) i = 0;
		}
		std::cout << std::endl;
	}
	bool sadrzi(T value) {
		int i = pocetak;
		int b = 0;
		while (b++ < brojac)
		{
			if (niz[i++] == value) return true;
			if (i == max) i = 0;
		}
		return false;
	}
};
#pragma endregion
#pragma endregion

#pragma region STEK
#pragma region STEK POV

template<class T>
class StekPov {
private:
	Cvor<T>* prvi;
public:
	StekPov() {
		prvi = nullptr;
	}
	void dodaj(T value) { // DODAVANJE NA POCETAK
		Cvor<T>* temp = new Cvor<T>(value, prvi);
		prvi = temp;
	}
	T ukloni() { // UKLANJANJE SA POCETKA
		if (isPrazan()) throw std::exception("Prazan stek!");

		Cvor<T>* temp = prvi;
		prvi = prvi->next;

		T info = temp->info;
		delete temp;
		return info;
	}
	T vrh() { // UZIMANJE ELEMENTA SA VRHA ( PRVI )
		if (isPrazan()) throw std::exception("Nemate elemenata u steku!");
		return prvi->info;
	}
	bool isPrazan() {
		return prvi == nullptr;
	}
	void print(std::string pre = "", std::string post = ", ") {
		Cvor<T>* temp = prvi;
		while (temp != nullptr)
		{
			std::cout << pre << temp->info << post;
			temp = temp->next;
		}
		std::cout << std::endl;
	}
	bool sadrzi(T value) {
		Cvor<T>* temp = prvi;
		while (temp != nullptr)
		{
			if (temp->info == value) return true;
			temp = temp->next;
		}
		return false;
	}
};

#pragma endregion
#pragma region STEK SEKV

template<class T>
class StekSekv {
private:
	int brojac, max;
	T* niz;
	void prosiriStek() {
		max *= 2;
		T* copy = niz;
		niz = new T[max];
		for (size_t i = 0; i < brojac; i++)
			niz[i] = copy[i];

		delete[] copy;
	}
public:
	StekSekv(int max = 10) {
		brojac = 0; this->max = max;
		niz = new T[max];
	}
	void dodaj(T value) { // DODAVANJE NA KRAJ
		if (brojac == max) prosiriStek();
		niz[brojac++] = value;
	}
	T ukloni() { // UKLANJANJE SA KRAJA
		if (brojac == 0) throw std::exception("Prazan stek!");
		return niz[--brojac];
	}
	T vrh() { // UZIMANJE ELEMENTA SA VRHA ( ZADNJI )
		if (brojac == 0) throw std::exception("Nemate elemenata u steku!");
		return niz[brojac - 1];
	}
	bool isPrazan() {
		return brojac == 0;
	}
	void print(std::string pre = "", std::string post = ", ") {
		for (size_t i = 0; i < brojac; i++)
			std::cout << pre << niz[i] << post;
		std::cout << std::endl;
	}
	bool sadrzi(T value) {
		for (size_t i = 0; i < brojac; i++)
			if (niz[i] == value) return true;
		return false;
	}
};

#pragma endregion
#pragma endregion

#pragma region LISTA
#pragma region LISTA POV
template<class T>
class ListaPov {
private:
	int brojac;
	Cvor<T>* prvi;
public:
	ListaPov() {
		brojac = 0;
		prvi = nullptr;
	}
	ListaPov(T* niz, int vel) : ListaPov() {
		for (size_t i = 0; i < vel; i++)
			dodaj(niz[i]);
	}
	ListaPov(ListaPov<T>* lst) : ListaPov() {
		for (size_t i = 0; i < lst->count(); i++)
			dodaj(lst.get(i));
	}
	ListaPov(ListaPov<T>& lst) : ListaPov(&lst) { }

	void dodaj(T value) { // DODAVANJE NA POCETAK
		Cvor<T>* temp = new Cvor<T>(value, prvi);
		prvi = temp;
		brojac++;
	}
	T ukloni() { // UKLANJANJE SA POCETKA
		if (isPrazan()) throw std::exception("Lista je prazna!");

		brojac--;
		Cvor<T>* temp = prvi;
		prvi = prvi->next;
		T info = temp->info;

		delete temp;
		return info;
	}
	bool ukloni(T value) {
		Cvor<T>* temp = prvi;
		Cvor<T>* previous = nullptr;

		while (temp != nullptr) {
			if (temp->info == value) break;
			previous = temp; temp = temp->next;
		}

		if (temp == nullptr) return false; // AKO ELEMENT NIJE PRONADJEN
		if (previous == nullptr) prvi = temp->next; // PRONADJENI ELEMENT JE PRVI
		else previous->next = temp->next; // PRONADJENI ELEMENT JE TEMP TE PRETHODNI VEZES ZA SLJEDBENIKA TEMPA KAKO BI TEMP MOGAO OBRISATI
		delete temp;
		return true;
	}
	bool isPrazan() {
		return (prvi == nullptr);
	}
	int count() {
		return brojac;
	}
	void print(std::string pre = "", std::string post = ", ") {
		Cvor<T>* temp = prvi;
		while (temp != nullptr) {
			std::cout << pre << temp->info << post;
			temp = temp->next;
		}
		std::cout << std::endl;
	}
	T& get(int i) {
		if (i > brojac) throw std::exception("Nevalidna vrijednost indexa");

		Cvor<T>* temp = prvi;
		for (size_t j = 0; j < (brojac - i - 1); j++)
			temp = temp->next;
		return temp->info;
	}
	T& operator[](int i) {
		return get(i);
	}
	void set(int i, T value) { // SETOVANJE VALUE NA INDEX I
		get(i) = value;
	}
	bool sadrzi(T value) {
		Cvor<T>* temp = prvi;
		while (temp != nullptr) {
			if (temp->info == value) return true;
			temp = temp->next;
		}
		return false;
	}
	T* formirajNiz() {
		T* niz = new T[this->brojac];

		int counter = 0;
		Cvor<T>* temp = prvi;

		while (temp != nullptr) {
			niz[counter++] = temp->info;
			temp = temp->next;
		}
		return niz;
	}
};
#pragma endregion
#pragma region LISTA SEKV

template<class T>
class ListaSekv {
private:
	int brojac, max;
	T* niz;
	void prosiriListu() {
		max *= 2;
		T* copy = niz;
		niz = new T[max];
		for (size_t i = 0; i < brojac; i++)
			niz[i] = copy[i];

		delete[] copy;
	}
public:
	ListaSekv(int max = 10) {
		brojac = 0; this->max = max;
		niz = new T[max];
	}
	ListaSekv(T* nizz, int vel, int max = 10) : ListaSekv(max) {
		for (size_t i = 0; i < vel; i++)
			dodaj(nizz[i]);
	}
	ListaSekv(ListaSekv<T>* lst, int max = 10) : ListaSekv(max) {
		for (size_t i = 0; i < lst->count(); i++)
			dodaj(lst->get(i));
	}
	ListaSekv(ListaSekv<T>& lst, int max = 10) : ListaSekv(&lst, max) { }

	void dodaj(T value) { // DODAVANJE NA KRAJ
		if (brojac == max) prosiriListu();
		niz[brojac++] = value;
	}
	T ukloni() { // UKLANJANJE SA KRAJA
		if (brojac == 0) throw std::exception("Lista je prazna!");
		return niz[--brojac];
	}
	bool isPrazan() {
		return brojac == 0;
	}
	int count() {
		return brojac;
	}
	void print(std::string pre = "", std::string post = ", ") {
		for (size_t i = 0; i < brojac; i++)
			std::cout << pre << niz[i] << post;
		std::cout << std::endl;
	}
	T& get(int i) {
		if (i >= brojac) throw std::exception("Nevalidna vrijednost indexa");
		return niz[i];
	}
	T& operator[](int i) {
		return get(i);
	}
	void set(int i, T value) {
		get(i) = value;
	}
	bool sadrzi(T value) {
		for (size_t i = 0; i < brojac; i++)
			if (niz[i] == value)
				return true;
		return false;
	}
	T* getNiz() {
		return niz;
	}
	T* formirajNiz() { // TOTALNO BESKORISNA FUNKCIJA
		// return getNiz();
		T* nizz = new T[this->brojac];
		for (size_t i = 0; i < this->brojac; i++)
			nizz[i] = this->niz[i];
		return nizz;
	}
};

#pragma endregion
#pragma endregion

#pragma region PRIOR RED
#pragma region PRIOR RED POV

template<class T>
class PrioritetniRedPov {
private:
	Cvor<T>* prvi;
public:
	PrioritetniRedPov() {
		prvi = nullptr;
	}
	void add(T value) { // DODAVANJE SORTIRANO
		Cvor<T>* novi = new Cvor<T>(value, nullptr);

		Cvor<T>* temp = prvi;
		Cvor<T>* previous = nullptr;

		while (temp != nullptr) {
			if (novi->info > temp->info) break;
			previous = temp; temp = temp->next;
		}
		if (previous == nullptr) prvi = novi; // AKO JE ELEMENT STAVLJAMO NA PRVO MJESTO
		else previous->next = novi; // INACE SLJEDECI OD PRETHODNIKA VEZEMO ZA NOVI CVOR
		novi->next = temp; // I NA KRAJU NOVI VEZEMO ZA NAREDNOG
	}
	T ukloni() { // UKLANJANJE SA POCETKA
		if (isPrazan()) throw std::exception("Prazan prioritetni red!");

		Cvor<T>* temp = prvi;
		prvi = prvi->next;
		T info = temp->info;
		delete temp;
		return info;
	}
	bool isPrazan() {
		return prvi == nullptr;
	}
	void print(std::string pre = "", std::string post = ", ") {
		Cvor<T>* temp = prvi;
		while (temp != nullptr) {
			std::cout << pre << temp->info << post;
			temp = temp->next;
		}
		std::cout << std::endl;
	}
};

#pragma endregion
#pragma region PRIOR RED SEKV

template<class T>
class PrioritetniRedSekv {
private:
	int brojac, max;
	T* niz;
	void prosiriRed() {
		max *= 2;
		T* copy = niz;
		niz = new T[max];
		for (size_t i = 0; i < brojac; i++)
			niz[i] = copy[i];

		delete[] copy;
	}
public:
	PrioritetniRedSekv(int max = 10) {
		brojac = 0;
		this->max = max;
		niz = new T[max];
	}
	bool sadrzi(T value) {
		for (size_t i = 0; i < brojac; i++)
			if (niz[i] == value) return true;
		return false;
	}
	void add(T value) { // DODAVANJE NA KRAJ
		if (brojac == max) prosiriRed();
		niz[brojac++] = value;
	}
	T ukloni() { // UKLANJANJE NAJVECEG
		if (isPrazan()) throw std::exception("Prazan prioritetni red!");

		T max = niz[0];
		int maxIndex = 0;
		for (size_t i = 1; i < brojac; i++)
		{
			if (niz[i] > max) {
				max = niz[i]; maxIndex = i; // NADJEMO MAX ELEMENT I NJEGOV INDEX
			}
		}
		niz[maxIndex] = niz[--brojac]; // STAVLJAMO NAJVECI NA KRAJ	
		return max;
	}
	bool isPrazan() {
		return brojac == 0;
	}
	void print(std::string pre = "", std::string post = ", ") {
		for (size_t i = 0; i < brojac; i++)
			std::cout << pre << niz[i] << post;
		std::cout << std::endl;
	}
};

#pragma endregion
#pragma region PRIOR RED HEAP

template<class T>
class PrioritetniRedHeap {
private:

public:

};

#pragma endregion
#pragma endregion

#pragma region HASHING
template<class T>
class Hash { // CHAINING
private:
	ListaPov<T>* niz;
	int n;
	int izracunajHash(T value) {
		return value % n;
	}
public:
	Hash(int n = 10) {
		this->n = n;
		niz = new ListaPov<T>[n];
	}
	void dodaj(T value) {
		niz[izracunajHash(value)].dodaj(value);
	}
	bool ukloni(T value) {
		return niz[izracunajHash(value)].ukloni(value);
	}
	void print() {
		std::cout << "********************\n";
		for (size_t i = 0; i < n; i++) {
			std::cout << "Lista " << i << ": \n";
			niz[i].print();
		}
		std::cout << "********************\n";
	}
};
#pragma endregion


int main() {

	/*Hash<int> hesiranje;
	for (size_t i = 0; i < 10; i++)
	{
		hesiranje.dodaj(rand() % 40 + i);
	}
	hesiranje.print();
	for (size_t i = 0; i < 10; i++)
	{
		hesiranje.ukloni(rand() % 40 + i);
	}
	hesiranje.print();*/

	/*PrioritetniRedSekv<int> sekvRed;
	for (size_t i = 0; i < 10; i++)
	{
		sekvRed.add(rand());
	}
	sekvRed.print();
	std::cout << sekvRed.ukloni() << "\n";
	std::cout << sekvRed.ukloni() << "\n";
	std::cout << sekvRed.ukloni() << "\n";
	sekvRed.print();*/


	system("pause>nul");
	return 1;
}