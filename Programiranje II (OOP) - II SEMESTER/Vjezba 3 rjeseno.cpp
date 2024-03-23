#include <iostream>
using namespace std;

//Koristene skracenice u komentarima
// dflt. = default
// user-def. = user-defined (korisnicki-definirano)
// ctor = constructor (konstruktor)

//Z1.0
char* alocirajTekst(const char* tekst) {
    if (tekst == nullptr)
        return nullptr;
    char* novi = new char[strlen(tekst) + 1];
    strcpy_s(novi, strlen(tekst) + 1, tekst);
    return novi;
}

class Datum
{
    int* _dan{ nullptr };
    int* _mjesec{ nullptr };
    int* _godina{ nullptr };
public:
    //Z1.1 Dflt. ctor
    Datum() {
        setDan(1);
        setMjesec(1);
        setGodina(2023);
    }
    //Z1.2 User-def. ctor
    Datum(int d, int m, int g) {
        setDan(d);
        setMjesec(m);
        setGodina(g);
    }
    //Z1.3
    int getDan() const { return (_dan == nullptr) ? 1 : *_dan; }
    int getMjesec() const { return (_mjesec == nullptr) ? 1 : *_mjesec; }
    int getGodina() const { return (_godina == nullptr) ? 2023 : *_godina; }
    //Z1.4
    void setDan(int dan) {
        if (_dan == nullptr)
            _dan = new int;
        *_dan = dan;
    }
    void setMjesec(int mjesec) {
        if (_mjesec == nullptr)
            _mjesec = new int;
        *_mjesec = mjesec;
    }
    void setGodina(int godina) {
        if (_godina == nullptr)
            _godina = new int;
        *_godina = godina;
    }
    //Z1.5
    void set(const Datum& obj) {
        setDan(obj.getDan());
        setMjesec(obj.getMjesec());
        setGodina(obj.getGodina());
    }
    //Z1.6
    void ispis() const {
        cout << getDan() << "." << getMjesec() << "." << getGodina();
    }
    //Z1.7
    ~Datum() {
        delete _dan, delete _mjesec, delete _godina;
    }
};
class Glumac
{
    char* _ime{ nullptr };
    char* _prezime{ nullptr };
    char* _zemljaPorijekla{ nullptr };
    Datum* _datumRodjenja{ nullptr };
    bool* _spol{ nullptr }; //1-Muski, 0-Zenski
public:
    //Z2.0 Dflt. ctor
    Glumac() {
    }
    //Z2.1 User-def. ctor
    Glumac(const char* ime, const char* prez, const char* zemlja, const Datum& datumRodjenja, bool spol) {
        setIme(ime);
        setPrezime(prez);
        setZemljaPorijekla(zemlja);
        setDatumRodjenja(datumRodjenja);
        setSpol(spol);
    }
    //Z2.2
    const char* getIme() const { return (_ime == nullptr) ? "" : _ime; }
    const char* getPrezime() const { return (_prezime == nullptr) ? "" : _prezime; }
    const char* getZemljaPorijekla() const { return (_zemljaPorijekla == nullptr) ? "" : _zemljaPorijekla; }
    const Datum& getDatumRodjenja() const { return *_datumRodjenja; }
    bool getSpol() const { return (_spol == nullptr) ? false : *_spol; }

    //Z2.3
    void setIme(const char* ime) {
        delete[] _ime;
        _ime = alocirajTekst(ime);
    }
    void setPrezime(const char* prezime) {
        delete[] _prezime;
        _prezime = alocirajTekst(prezime);
    }
    void setZemljaPorijekla(const char* zemlja) {
        delete[] _zemljaPorijekla;
        _zemljaPorijekla = alocirajTekst(zemlja);
    }
    void setDatumRodjenja(const Datum& datumRodjenja) {
        if (_datumRodjenja == nullptr)
            _datumRodjenja = new Datum;
        _datumRodjenja->set(datumRodjenja);
    }
    void setSpol(bool spol) {
        if (_spol == nullptr)
            _spol = new bool;
        *_spol = spol;
    }
    //Z2.4
    void set(const Glumac& g) {
        setIme(g.getIme());
        setPrezime(g.getPrezime());
        setZemljaPorijekla(g.getZemljaPorijekla());
        setDatumRodjenja(g.getDatumRodjenja());
        setSpol(g.getSpol());
    }
    //Z2.5
    void ispis() const {
        cout << "Ime i prezime: " << getIme() << " " << getPrezime() << endl;
        cout << "Zemlja porijekla: " << getZemljaPorijekla() << endl;
        cout << "Datum rodjenja: ";
        getDatumRodjenja().ispis();
        cout << endl;
        cout << "Spol: " << (getSpol() ? "Muski" : "Zenski") << endl;
    }
    //Z2.6
    ~Glumac() {
        delete[] _ime, delete[] _prezime, delete[] _zemljaPorijekla;
        delete _datumRodjenja, delete _spol;
    }
};

class Epizoda {
    char* _naziv{ nullptr };
    int* _trajanje{ nullptr }; //u minutama
    char _kratakSadrzaj[100] = "";
    Datum _datumPremijere;

    int _maxOcjena; // velicina niza '_ocjene'
    int _trenutnoOcjena = 0; //brojac 
    int* _ocjene{ nullptr };
public:
    Epizoda() {
    }
    //Z3.1
    Epizoda(const char* naziv, int trajanje, const char* kratakOpis, const Datum& datumPremijere, int ukupnoOcjena)
    {
        setNaziv(naziv);
        setTrajanje(trajanje);
        setKratakSadrzaj(kratakOpis);
        setDatumPremijere(datumPremijere);
        setOcjene(0, ukupnoOcjena);
    }

    //Z3.2
    const char* getNaziv() const { return (_naziv == nullptr) ? "" : _naziv; }
    int getTrajanje() const { return (_trajanje == nullptr) ? 0 : *_trajanje; }
    const char* getKratakSadrzaj() const { return _kratakSadrzaj; }
    const Datum& getDatumPremijere() const { return _datumPremijere; }
    int getTrenutnoOcjena() const { return _trenutnoOcjena; }
    int getMaxBrojOcjena() const { return _maxOcjena; }
    int* getOcjene() const { return _ocjene; }

    //Z3.3
    int getOcjena(int index) const {
        if (index < 0 || index >= getTrenutnoOcjena())
            return 0;
        return _ocjene[index];
    }
    //Z3.4
    void setNaziv(const char* naziv) {
        delete[] _naziv;
        _naziv = alocirajTekst(naziv);
    }
    void setTrajanje(int trajanje) {
        if (_trajanje == nullptr)
            _trajanje = new int;
        *_trajanje = trajanje;
    }
    void setKratakSadrzaj(const char* kratakSadrzaj) {
        strcpy_s(_kratakSadrzaj, size(_kratakSadrzaj), kratakSadrzaj);
    }
    void setDatumPremijere(const Datum& datum) {
        _datumPremijere.set(datum);
    }

    //Z3.5
    //funkcija koja brise postojeci niz i kreira novi na osnovu tri unesena parametra
    void setOcjene(int trenutnoOcjena, int maxOcjena, int* ocjene = nullptr) {
        delete[] _ocjene; // dealokacija postojecih ocjena
        _maxOcjena = maxOcjena; // setovanje novih dimenzija niza
        _ocjene = new int[maxOcjena]; // alokacija novog dinamickog niza [nove velicine]
        _trenutnoOcjena = 0; //podesavanje brojaca na 0 [buduci da je tek kreiran niz]
        if (ocjene != nullptr) {
            //ukoliko nije drugi ulazni parametar 'ocjene' anuliran
            //u tom slucaju radimo kopiranje vrijednosti elemenata tog niza u nas niz
            for (int i = 0; i < trenutnoOcjena; i++)
                dodajOcjenu(ocjene[i]); //u tu svrhu mozemo iskoristiti funkciju za dodavanje ocjena
        }
    }

    //Z3.6
    void set(const Epizoda& e) {
        setNaziv(e.getNaziv());
        setTrajanje(e.getTrajanje());
        setKratakSadrzaj(e.getKratakSadrzaj());
        setDatumPremijere(e.getDatumPremijere());
        setOcjene(e.getTrenutnoOcjena(), e.getMaxBrojOcjena(), e.getOcjene());
    }


    //Z3.7
    //Prosiriti niz _ocjene na sljedeci nacin:
    //  *Konstruisati novi niz velicine [_maxBrojOcjena + prosiriZa]
    //  *Kopirati vrijednosti iz starog niza u novi niz
    //  *Dealocirati stari niz
    void expandOcjene(int uvecanje) {
        if (uvecanje <= 0)
            return;
        int* temp = _ocjene;
        _ocjene = new int[_maxOcjena + uvecanje];
        for (int i = 0; i < _maxOcjena; i++)
            _ocjene[i] = temp[i];
        _maxOcjena += uvecanje;
        delete[] temp;
        temp = nullptr;
    }

    //Z3.8
    //Ukoliko je brojac dosao do kraja (jednak velicini niza), uraditi prosirivanje niza za 10 elemenata;
    void dodajOcjenu(int ocjena) {
        if (_trenutnoOcjena == _maxOcjena)
            expandOcjene(10);
        _ocjene[_trenutnoOcjena] = ocjena;
        _trenutnoOcjena++;
    }
    //Z3.9
    bool ukloniZadnjuOcjenu() {
        if (_trenutnoOcjena == 0)
            return false;
        _trenutnoOcjena--;
        return true;
    }

    //Z3.10
    float getProsjecnaOcjena() const {
        float suma = 0.0f;
        if (_trenutnoOcjena == 0)
            return suma;
        for (int i = 0; i < _trenutnoOcjena; i++)
            suma += _ocjene[i];
        return  suma / _trenutnoOcjena;
    }
    //Z3.11
    void ispis() const {
        cout << "Naziv: " << getNaziv() << endl;
        cout << "Trajanje (u minutama): " << getTrajanje() << endl;
        cout << "Kratak sadrzaj: " << getKratakSadrzaj() << endl;
        cout << "Premijerno prikazivanje: ";
        getDatumPremijere().ispis();
        cout << endl;
        cout << "Prosjecna ocjena: " << getProsjecnaOcjena() << endl;

    }
    //Z3.12
    ~Epizoda() {
        delete[] _naziv, delete[] _ocjene; //dealociranje nizova
        delete _trajanje; //dealociranje jedne varijable
    }
};
class Uloga {
    Glumac* _glumac{ nullptr };
    char* _opis{ nullptr };
    char* _tipUloge{ nullptr }; //Glavna, sporedna, epizodna, statista, gostujuca zvijezda, cameo ...
public:
    //Z4.0
    Uloga() {
    }
    //Z4.1
    Uloga(const Glumac& glumac, const char* opis, const char* tip) {
        setGlumac(glumac);
        setOpis(opis);
        setTipUloge(tip);
    }

    //Z4.2
    const Glumac& getGlumac() const { return *_glumac; }
    const char* getOpis() const { return (_opis == nullptr) ? "" : _opis; }
    const char* getTipUloge() const { return (_tipUloge == nullptr) ? "" : _tipUloge; }

    //Z4.3
    void setGlumac(const Glumac& glumac) {
        if (_glumac == nullptr)
            _glumac = new Glumac;
        _glumac->set(glumac);
    }
    void setOpis(const char* opis) {
        delete[] _opis;
        _opis = alocirajTekst(opis);
    }
    void setTipUloge(const char* tipUloge) {
        delete[] _tipUloge;
        _tipUloge = alocirajTekst(tipUloge);
    }
    //Z4.4
    void set(const Uloga& u) {
        setGlumac(u.getGlumac());
        setOpis(u.getOpis());
        setTipUloge(u.getTipUloge());
    }
    //Z4.5
    void ispis() const {
        cout << "Glumac: " << endl;
        getGlumac().ispis();
        cout << "Opis uloge: " << getOpis() << endl;
        cout << "Tip uloge: " << getTipUloge() << endl;
    }
    //Z4.6
    ~Uloga() {
        delete _glumac; //dealociranje objekta
        delete[] _opis, delete[] _tipUloge; //dealociranje nizova
    }
};
class Serija {
    char* _naziv{ nullptr };
    int _trenutnoUloga = 0;
    Uloga* _uloge[50] = { nullptr }; //Svi elementi (pokazivaci) se postavljaju na NULL

    int _maxBrojEpizoda = 0;
    int _trenutnoEpizoda = 0;
    Epizoda* _epizode{ nullptr };
public:
    //Z5.1
    Serija(const char* naziv, int maxBrojEpizoda) {
        setNaziv(naziv);
        setUloge(0);
        setEpizode(0, maxBrojEpizoda);
    }

    //Z5.2
    const char* getNaziv() const { return (_naziv == nullptr) ? "" : _naziv; }
    int getTrenutnoUloga() const { return _trenutnoUloga; }
    Uloga** getUloge() const { return (Uloga**)_uloge; }
    int getTrenutnoEpizoda() const { return _trenutnoEpizoda; }
    int getMaxBrojEpizoda() const { return _maxBrojEpizoda; }
    Epizoda* getEpizode() const { return _epizode; }

    //Z5.3
    void setNaziv(const char* naziv) {
        delete[] _naziv;
        _naziv = alocirajTekst(naziv);
    }

    //Z5.4 :: izbrisati postojece uloge i kreirati nove na osnovu ulaznih parametara
    void setUloge(int trenutnoUloga, Uloga** uloge = nullptr) {
        for (int i = 0; i < _trenutnoUloga; i++)
            delete _uloge[i];
        _trenutnoUloga = 0;
        if (uloge != nullptr)
            for (int i = 0; i < trenutnoUloga; i++)
                dodajUlogu(*uloge[i]);

    }

    //Z5.5 :: izbrisati postojece epizode i kreirati nove na osnovu ulaznih parametara
    void setEpizode(int trenutnoEpizoda, int maxBrojEpizoda, Epizoda* epizode = nullptr) {
        delete[] _epizode;
        _maxBrojEpizoda = maxBrojEpizoda;
        _trenutnoEpizoda = 0;
        _epizode = new Epizoda[_maxBrojEpizoda];
        if (epizode != nullptr)
            for (int i = 0; i < trenutnoEpizoda; i++)
                dodajEpizodu(epizode[i]);
    }

    //Z5.6 :: funkcija za dodavanje uloge u niz pokazivaca
    bool dodajUlogu(const Uloga& uloga) {
        if (_trenutnoUloga == size(_uloge))
            return false;
        //Obzirom da objekti (tipa Uloga) vec postoje, koristimo settere
        _uloge[_trenutnoUloga] = new Uloga;
        _uloge[_trenutnoUloga]->set(uloga);
        _trenutnoUloga++;
        return true;

    }
    //Z5.7 :: funkcija za dodavanje epizoda u niz epizoda
    bool dodajEpizodu(const Epizoda& ep) {
        if (_trenutnoEpizoda == _maxBrojEpizoda)
            return false;
        _epizode[_trenutnoEpizoda].set(ep);
        _trenutnoEpizoda++;
        return true;
    }

    //Z5.8 :: funkcija vraca adresu epizode sa najvecom prosjecnom ocjenom
    Epizoda* getNajboljeOcijenjenaEpizoda() {
        Epizoda* adresa = &_epizode[0]; //adresa 0-og elementa u nizu
        float najveca = 0.0;
        for (int i = 0; i < _trenutnoEpizoda; i++) {
            if (najveca <= _epizode[i].getProsjecnaOcjena()) {
                najveca = _epizode[i].getProsjecnaOcjena();
                adresa = _epizode + i;
            }
        }
        return adresa;
    }

    //Z5.9 :: Pored ostalih atributa ispisati i sve uloge i sve epizode
    void ispis() {
        cout << "Naziv serije: " << getNaziv() << endl;
        cout << "Broj uloga: " << getTrenutnoUloga() << endl;
        for (int i = 0; i < getTrenutnoUloga(); i++)
        {
            cout << "**************************************************\n";
            cout << "Uloga " << "[" << i + 1 << "]" << endl;
            cout << "---------------------------------------------\n";
            _uloge[i]->ispis();
            cout << "---------------------------------------------\n";
        }
        cout << "Broj epizoda: " << getTrenutnoEpizoda() << endl;
        for (int i = 0; i < getTrenutnoEpizoda(); i++)
        {
            cout << "**************************************************\n";
            cout << "Epizoda " << "[" << i + 1 << "]" << endl;
            cout << "---------------------------------------------\n";
            _epizode[i].ispis();
            cout << "---------------------------------------------\n";
        }
    }
    //Z5.10
    ~Serija() {
        delete[] _naziv;
        for (int i = 0; i < size(_uloge); i++)
            delete _uloge[i];
        delete[] _epizode;
    }
};
void zadatak1() {
    cout << "Testiranje klase 'Datum'\n\n";
    Datum novaGodina; //Def. ctor
    novaGodina.setDan(1);
    novaGodina.setMjesec(1);
    novaGodina.setGodina(2023);
    novaGodina.ispis();
    cout << endl;
    Datum prviFebruar(novaGodina.getDan(), novaGodina.getMjesec() + 1, novaGodina.getGodina());
    prviFebruar.ispis();
    cout << endl;

    Datum prviMart(1, 3, 2023); //User-def. ctor
    prviMart.ispis();
    cout << endl;
    cout << "Dealokacija ..." << endl;
}

void zadatak2() {
    cout << "Testiranje klase 'Glumac'\n\n";
    Glumac ryanGosling; //Def. ctor
    ryanGosling.setIme("Ryan");
    ryanGosling.setPrezime("Gosling");
    ryanGosling.setSpol(1);
    ryanGosling.setDatumRodjenja(Datum(1, 1, 1980));
    ryanGosling.setZemljaPorijekla("Kanada");
    ryanGosling.ispis();
    cout << endl;
    //
    Glumac harrisonFord("Harrison", "Ford", "SAD", Datum(2, 2, 1955), 1); //User-def. ctor
    Glumac michellePfeifer("Michelle", "Pfeiffer", "SAD", Datum(3, 3, 1966), 0); //User-def. ctor
    harrisonFord.ispis();
    cout << endl;
    michellePfeifer.ispis();
    cout << endl;

    Glumac jackNicholson;
    jackNicholson.setIme("Jack");
    jackNicholson.setPrezime("Nicholson");
    jackNicholson.setDatumRodjenja(Datum(1, 4, 1945));
    jackNicholson.ispis();
    cout << endl;

    Glumac heathLedger;
    heathLedger.setIme("Heath");
    heathLedger.setPrezime("Ledger");
    heathLedger.setDatumRodjenja(Datum(5, 3, 1983));
    heathLedger.setZemljaPorijekla("Australija");
    heathLedger.ispis();
    cout << endl;
    cout << "Dealokacija ..." << endl;
}
void zadatak3() {
    cout << "Testiranje klase 'Epizoda'\n\n";
    Epizoda e1;
    e1.setNaziv("What's Cooking?");
    e1.setTrajanje(21);
    e1.setKratakSadrzaj("Bender decides to become a chef so ...");
    e1.setDatumPremijere(Datum(5, 5, 2023));
    e1.ispis();
    cout << endl;

    Epizoda e2("This Mission is Trash", 22, "Fry, Leela, and Bender travel to the garbage meteor and discover loads of discardedjunk.", Datum(13, 5, 2023), 10);
    e2.ispis();
    cout << endl;

    Epizoda e3;
    e3.setNaziv("Smell-o-Scope");
    e3.setTrajanje(20);
    e3.setKratakSadrzaj("Using Professor Farnsworth's Smell-o-Scope, Fry locates the stinkiest object in the universe.");
    e3.setDatumPremijere(Datum(21, 5, 2023));
    e3.ispis();
    cout << endl;

    Epizoda e4;
    e4.setNaziv("Electric Drug");
    e4.setTrajanje(24);
    e4.setKratakSadrzaj("Bender's electricity addiction puts the Planet Express crew in danger");
    e4.setDatumPremijere(Datum(29, 5, 2023));
    for (int i = 0; i < 15; i++)
        e4.dodajOcjenu(rand() % 10 + 1);
    e4.ukloniZadnjuOcjenu();
    e4.ukloniZadnjuOcjenu(); //Brisemo zadnje dvije ocjene
    cout << endl;
    e4.ispis();
    cout << "Dealokacija ..." << endl;
}

void zadatak4() {
    cout << "Testiranje klase 'Uloga'\n\n";
    Glumac seanConnery("Sean", "Connery", "Velika Britanija", Datum(25, 8, 1930), 1);
    Glumac danielCraig("Daniel", "Craig", "Velika Britanija", Datum(2, 3, 1968), 1);
    Uloga jamesBond(seanConnery, "MI6 Detective James Bond ....", "Main role");
    jamesBond.setGlumac(danielCraig);
    jamesBond.setOpis("After earning 00 status and a licence to kill, Secret Agent James Bond sets out on his first mission as 007.");
    jamesBond.setTipUloge("Main role");
    jamesBond.ispis();
    cout << "Dealokacija ..." << endl;
}

void zadatak5() {
    cout << "Testiranje klase 'Serija'\n\n";
    Serija teorijaVelikogPraska("The Big Bang Theory", 200);

    Glumac jimParsons("Jim", "Parsons", "SAD", Datum(17, 7, 1967), 1);
    Glumac johnnyGalecki("Johnny", "Galecki", "SAD", Datum(15, 3, 1975), 1);
    Glumac kaleyCuoco("Kaley", "Cuoco", "SAD", Datum(13, 4, 1985), 0);
    Uloga sheldonCooper(jimParsons, "Dr. Sheldon Cooper, a theoretical physicist at Caltech", "Series regular");
    Uloga leonardHofstadter(johnnyGalecki, "Dr. Leonard Hofstadter, a experimental physicist at Caltech", "Series regular");
    Uloga penny(kaleyCuoco, "Penny, a waitress at Cheesecake factory", "Series regular");
    //Serija::Dodavanje uloga
    teorijaVelikogPraska.dodajUlogu(sheldonCooper);
    teorijaVelikogPraska.dodajUlogu(leonardHofstadter);
    teorijaVelikogPraska.dodajUlogu(penny);

    Epizoda ep1("The Big Bran Hypothesis", 22, "When Sheldon and Leonard drop off a box of flat packfurniture...", Datum(1, 6, 2023), 100);
    Epizoda ep2("The Luminous Fish Effect", 21, "Sheldon is fired from his job as a physicist afterinsulting his new boss...", Datum(8, 6, 2023), 100);
    Epizoda ep3("The Bat Jar Conjecture", 22, "The guys decide to compete in a university quiz calledphysics bowl...", Datum(15, 6, 2023), 100);
    Epizoda ep4("The Nerdvana Annihilation", 21, "In an online auction, Leonard buys a full-sized replica o the time machine...", Datum(22, 6, 2023), 100);

    //Epizoda::dodajOcjenu
    int ocjene1[] = { 5,7,8 };
    int ocjene2[] = { 10,5,7,10,9 };
    int ocjene3[] = { 9,8,9,9 };
    int ocjene4[] = { 10,5,3,7,6,6 };

    //Foreach petlja
    for (int& ocjena : ocjene1)
        ep1.dodajOcjenu(ocjena);
    for (int& ocjena : ocjene2)
        ep2.dodajOcjenu(ocjena);
    for (int& ocjena : ocjene3)
        ep3.dodajOcjenu(ocjena);
    for (int& ocjena : ocjene4)
        ep4.dodajOcjenu(ocjena);

    //Serija::dodajEpizodu
    teorijaVelikogPraska.dodajEpizodu(ep1);
    teorijaVelikogPraska.dodajEpizodu(ep2);
    teorijaVelikogPraska.dodajEpizodu(ep3);
    teorijaVelikogPraska.dodajEpizodu(ep4);
    teorijaVelikogPraska.ispis();

    Epizoda* ep = teorijaVelikogPraska.getNajboljeOcijenjenaEpizoda();
    cout << "Najbolje ocijenjena epizoda: " << ep->getNaziv() << endl;
    cout << "Ocjena: " << ep->getProsjecnaOcjena() << endl;
    cout << "Dealokacija ..." << endl;
}

void menu() {
    int nastaviDalje = 1;
    while (nastaviDalje == 1) {
        int izbor = 0;
        do {
            system("cls");
            cout << "::Zadaci::" << endl;
            cout << "(1) Zadatak 1" << endl;
            cout << "(2) Zadatak 2" << endl;
            cout << "(3) Zadatak 3" << endl;
            cout << "(4) Zadatak 4" << endl;
            cout << "(5) Zadatak 5" << endl;
            cout << "Unesite odgovarajuci broj zadatka za testiranje: -->: ";
            cin >> izbor;
            cout << endl;
        } while (izbor < 1 || izbor > 5);
        switch (izbor) {
        case 1: zadatak1(); cout << "Zadatak 1. Done." << endl; break;
        case 2: zadatak2(); cout << "Zadatak 2. Done." << endl; break;
        case 3: zadatak3(); cout << "Zadatak 3. Done." << endl; break;
        case 4: zadatak4(); cout << "Zadatak 4. Done." << endl; break;
        case 5: zadatak5(); cout << "Zadatak 5. Done." << endl; break;
        default:break;
        }
        do {
            cout << "DA LI ZELITE NASTAVITI DALJE? (1/0): ";
            cin >> nastaviDalje;
        } while (nastaviDalje != 0 && nastaviDalje != 1);
    }
}
int main() {
    menu();
    return 0;
}