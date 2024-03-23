#include <iostream>

using namespace std;

int suma(int n) {
    if (n <= 1)      // ponavljanje dok n ne postane 1?
        return 1;   // izlazak iz rekurzije
    return n + suma(n - 1);    // povratne vrijednost i poziv iste funkcije sa umanjenim n za 1
}

int main() {
    cout << "Suma prvih 5 brojeva . Rekurzija" << endl;
    int s;

    s = suma(5);      // poziv funkcije suma

    cout << "Suma brojeva od 1 do 5 = " << s << endl;     // ispis vrijednosti ulaznih i izlaznih varijabli
    return 0;
}