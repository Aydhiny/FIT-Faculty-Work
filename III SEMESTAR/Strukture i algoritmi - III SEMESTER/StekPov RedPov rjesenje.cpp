#include <iostream>
#include <exception>
#include <random>
using namespace std;

int random_broj(int min = 0, int max = 100) {
    if (min > max) {
        std::cerr << "Error: Invalid arguments - min must be less than or equal to max." << std::endl;
        std::swap(min, max); // Swap min and max values
    }

    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<int> dist(min, max);

    return dist(rng);
}

struct Tacka2D {
    int x;
    int y;
    Tacka2D(int x, int y)
    {
        this->x = x;
        this->y = y;
    }
};

Tacka2D random_tacka() {
    return Tacka2D(random_broj(-100, +100), random_broj(-100, +100));
}

template <class Tip>
struct Cvor {
    Cvor* next;
    Tip info;

    Cvor(Tip info, Cvor<Tip>* next) : info(info)
    {
        this->next = next;
    }
};

template <class Tip>
class Red {
public:
    virtual void dodaj(Tip x) = 0;
    virtual bool jelPrazan() = 0;
    virtual Tip ukloni() = 0;
    virtual ~Red() {}
};

template <class Tip>
class RedPov : public Red<Tip> {
private:
    Cvor<Tip>* pocetak;
    Cvor<Tip>* kraj;
public:
    RedPov() : pocetak(nullptr), kraj(nullptr) {}

    void dodaj(Tip value) override {
        Cvor<Tip>* temp = new Cvor<Tip>(value, nullptr);
        if (!jelPrazan()) {
            kraj->next = temp;
            kraj = temp;
        }
        else {
            pocetak = kraj = temp;
        }
    }

    Tip ukloni() override {
        if (jelPrazan())
            throw std::exception("Prazan red!");

        Cvor<Tip>* temp = pocetak;
        pocetak = pocetak->next;

        if (pocetak == nullptr)
            kraj = nullptr;

        Tip info = temp->info;
        delete temp;
        return info;
    }

    bool jelPrazan() override {
        return pocetak == nullptr;
    }

    ~RedPov() {
        while (!jelPrazan())
            ukloni();
    }
};

template <class Tip>
class Stek {
public:
    virtual void dodaj(Tip x) = 0;
    virtual bool jelPrazan() = 0;
    virtual Tip ukloni() = 0;
    virtual ~Stek() {}
};

template <class T>
class StekPov : public Stek<T> {
private:
    Cvor<T>* prvi;
public:
    StekPov() : prvi(nullptr) {}

    void dodaj(T value) override {
        Cvor<T>* temp = new Cvor<T>(value, prvi);
        prvi = temp;
    }

    T ukloni() override {
        if (jelPrazan())
            throw std::exception("Prazan stek!");

        Cvor<T>* temp = prvi;
        prvi = prvi->next;

        T info = temp->info;
        delete temp;
        return info;
    }

    T vrh() {
        if (jelPrazan())
            throw std::exception("Nemate elemenata u steku!");
        return prvi->info;
    }

    bool jelPrazan() override {
        return prvi == nullptr;
    }

    ~StekPov() {
        while (!jelPrazan())
            ukloni();
    }
};

int main() {
    Red<Tacka2D>* red1 = new RedPov<Tacka2D>;

    for (int i = 0; i < 100; i++)
        red1->dodaj(random_tacka());

    Stek<int>* stek1 = new StekPov<int>;
    Stek<int>* stek2 = new StekPov<int>;

    while (!red1->jelPrazan()) {
        Tacka2D b = red1->ukloni();
        if (b.x > 10)
            stek1->dodaj(b.x);
        else
            stek2->dodaj(b.y);
    }

    cout << "------STEK 1: ";
    while (!stek1->jelPrazan())
        cout << stek1->ukloni() << ", ";
    cout << endl << endl;

    cout << "------STEK 2: ";
    while (!stek2->jelPrazan())
        cout << stek2->ukloni() << ", ";
    cout << endl << endl;

    delete red1;
    delete stek1;
    delete stek2;

    return 0;
}