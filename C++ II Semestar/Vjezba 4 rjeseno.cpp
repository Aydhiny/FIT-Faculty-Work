#include <iostream>
using namespace std;

// Koristene skracenice u komentarima
//  user-def. = user-defined (korisnicki-definirano)
//  ctor = constructor (konstruktor)
//  copy ctor = copy constructor (konstruktor kopije)
//  dtor = destructor

// Z0.1 :: dinamicka alokacija niza karaktera i kopiranje
char* alocirajTekst(const char* tekst) {
    if (tekst == nullptr)
        return nullptr;
    char* novi = new char[strlen(tekst) + 1];
    strcpy_s(novi, strlen(tekst) + 1, tekst);
    return novi;
}

// Z0.2 :: Vratiti broj znamenki za dati broj
int izracunajBrojZnamenki(int broj) {
    return (broj == 0) ? 1 : int(log10(abs(broj))) + 1;
}

// Z0.3 :: Pretvoriti (int) u (char*) [
// * uraditi dinamicku alokaciju memorije (dinamicki niz karaktera)
// * koristiti funkciju '_itoa_s' za prevodjenje vrijednosti int u niz karaktera.
char* intToStr(int broj) {
    int vel = izracunajBrojZnamenki(broj) + 1;
    char* tekst = new char[vel];
    _itoa_s(broj, tekst, vel, 10);
    return tekst;
}

// Z0.4 :: Funkcija koja vraca logicku vrijednost u zavisnosti da li je proslijedjena godina prijestupna ili ne
bool prijestupnaGodina(int godina) {
    return (((godina % 4 == 0) && (godina % 100 != 0)) ||
        (godina % 400 == 0));
}

// Z0.5 :: Vratiti broj dana za dati mjesec (Voditi racuna o prijestupnim godinama)
int getBrojDanaUMjesecu(int mjesec, int godina) {
    if (mjesec <= 0 || mjesec > 12 || godina <= 0)
        return 0;
    switch (mjesec) {
    case 4: case 6: case 9: case 11:  return 30;
    case 2: return prijestupnaGodina(godina) ? 29 : 28;
    default:
        return 31;
    }
}

class Datum
{
    int* _dan = nullptr;
    int* _mjesec = nullptr;
    int* _godina = nullptr;
public:
    // Z1.1 :: getteri
    int getDan() const { return (_dan == nullptr) ? 1 : *_dan; }
    int getMjesec() const { return (_mjesec == nullptr) ? 1 : *_mjesec; }
    int getGodina() const { return (_godina == nullptr) ? 2023 : *_godina; }

    // Z1.2 :: setteri
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
    // Z1.3 :: Dflt. ctor 
    Datum() {
    }
    // Z1.4 :: User-def. ctor
    Datum(int d, int m, int g) {
        setDan(d);
        setMjesec(m);
        setGodina(g);
    }
    // Z1.5 :: Copy ctor
    Datum(const Datum& obj) {
        setDan(obj.getDan());
        setMjesec(obj.getMjesec());
        setGodina(obj.getGodina());
    }

    // Z1.6 :: Operator = 
    Datum& operator =(const Datum& obj) {
        if (this != &obj) { // Ukoliko su adrese objekata razlicite, tek tada ima smisla raditi kopiranje
            setDan(obj.getDan());
            setMjesec(obj.getMjesec());
            setGodina(obj.getGodina());
        }
        return *this;
    }

    // Z1.7 :: dtor
    ~Datum() {
        delete _dan, delete _mjesec, delete _godina;
    }
};

// Z1.8 :: Ispisati datum
ostream& operator << (ostream& COUT, const Datum obj) {
    COUT << obj.getDan() << "." << obj.getMjesec() << "." << obj.getGodina();
    return COUT;
}

// Z1.9 :: Porediti dva datuma po vrijednostima atributa
bool operator == (const Datum& d1, const Datum& d2) {
    return d1.getDan() == d2.getDan()
        && d1.getMjesec() == d2.getMjesec()
        && d1.getGodina() == d2.getGodina();
}
bool operator != (const Datum& d1, const Datum& d2) {
    return !(d1 == d2);
}
// Z1.10 :: Kreirati novi datum kao rezultat dodavanja varijable 'brojDana' na datumski objekt 'obj'
Datum operator + (Datum& obj, int brojDana) {
    int dan = obj.getDan(), mjesec = obj.getMjesec(), godina = obj.getGodina();
    for (int i = 0; i < brojDana; i++) {
        if (dan + 1 <= getBrojDanaUMjesecu(mjesec, godina))
            dan++;
        else {
            dan = 1;
            if (mjesec + 1 <= 12)
                mjesec++;
            else {
                mjesec = 1;
                godina++;
            }
        }
    }
    return Datum(dan, mjesec, godina);
}
// Z1.11 :: Provjeriti da li je 'd1' veci (noviji datum) od 'd2'
bool operator > (const Datum& d1, const Datum& d2) {
    return d1.getGodina() * 365 + d1.getMjesec() * 30 + d1.getDan()
            > d2.getGodina() * 365 + d2.getMjesec() * 30 + d2.getDan();
}
bool operator >= (const Datum& d1, const Datum& d2) {
    return (d1 > d2) || (d1 == d2);
}
bool operator <(const Datum& d1, const Datum& d2) {
    return !(d1 >= d2);
}
bool operator <=(const Datum& d1, const Datum& d2) {
    return !(d1 > d2);
}

// Z1.12 :: Od dva datuma vratiti onaj stariji
const Datum& min(const Datum& d1, const Datum& d2) {
    return (d1 < d2) ? d1 : d2;
}

// Z1.13 :: Od dva datuma vratiti onaj noviji
const Datum& max(const Datum& d1, const Datum& d2) {
    return (d1 > d2) ? d1 : d2;
}

// Z1.14 :: Izracunati razliku (u danima) izmedju datumskih objekata 'd1' i 'd2'
int operator -(Datum& d1, Datum& d2) {
    if (d1 == d2) return 0;
    int counter = 0;
    Datum stariji = min(d1, d2), noviji = max(d1, d2);
    while (stariji + counter < noviji)
        counter++;
    return counter;
}

class Clan {
    const int _clanId;
    char _korisnickoIme[30] = "";
    char _lozinka[20] = "";
    Datum* _datumRegistracije = nullptr;
    bool* _spol = nullptr;
    // staticki atribut
    static int _brojacClanova;
public:

    // Z2.1 :: getteri
    const int getClanId() const { return _clanId; }
    const char* getKorisnickoIme() const { return _korisnickoIme; }
    const char* getLozinka() const { return _lozinka; }
    Datum getDatumRegistracije() const { return (_datumRegistracije == nullptr) ? Datum(1, 1, 2023) : *_datumRegistracije; }
    bool getSpol() const { return (_spol == nullptr) ? false : *_spol; }
    // staticki getter [dohvacanje vrijednosti statickog atributa 'brojacClanova'. prilikom dohvacanja uvecati vrijednost brojaca]
    static int getNextId() { return Clan::_brojacClanova++; }


    // Z2.2 :: setteri
    void setKorisnickoIme(const char* korisnickoIme) {
        strcpy_s(_korisnickoIme, size(_korisnickoIme), korisnickoIme);
    }
    void setLozinka(const char* lozinka) {
        strcpy_s(_lozinka, size(_lozinka), lozinka);
    }
    void setDatumRegistracije(Datum datumRegistracije) {
        if (_datumRegistracije == nullptr)
            _datumRegistracije = new Datum;
        *_datumRegistracije = datumRegistracije;
    }
    void setSpol(bool spol) {
        if (_spol == nullptr)
            _spol = new bool;
        *_spol = spol;
    }

    //  Z2.3 :: Dflt. ctor  [Postaviti konstantu '_clanId' na povratnu vrijednost staticke funkcije 'getNextId']
    Clan() : _clanId(getNextId()) {
    }
    //  Z2.4 :: User-def. ctor [Postaviti _clanId na na povratnu vrijednost staticke funkcije 'getNextId']. 
    Clan(const char* korisnickoIme, const char* lozinka, Datum datumReg, bool spol) :_clanId(getNextId())
    {
        setKorisnickoIme(korisnickoIme);
        setLozinka(lozinka);
        setDatumRegistracije(datumReg);
        setSpol(spol);

    }
    //  Z2.5 :: Copy ctor [kopirati obj._clanId u _clanId] :: koristiti getter 'obj.GetClanId'
    Clan(const Clan& obj) : _clanId(obj.getClanId()) {
        setKorisnickoIme(obj.getKorisnickoIme());
        setLozinka(obj.getLozinka());
        setDatumRegistracije(obj.getDatumRegistracije());
        setSpol(obj.getSpol());
    }

    // Z2.6 :: operator dodjele
    Clan& operator = (const Clan& obj) {
        if (this != &obj) {
            setKorisnickoIme(obj.getKorisnickoIme());
            setLozinka(obj.getLozinka());
            setDatumRegistracije(obj.getDatumRegistracije());
            setSpol(obj.getSpol());
        }
        return *this;
    }

    // Z2.7 :: dtor
    ~Clan() {
        delete _datumRegistracije, delete _spol;
    }
};
int Clan::_brojacClanova = 1; //  Inicijalizacija statickog atributa

// Z2.8 :: Ispisati podatke o clanu
ostream& operator <<(ostream& COUT, const Clan& clan)
{
    COUT << "Korisnicko ime: " << clan.getKorisnickoIme() << endl;
    COUT << "Datum registracije: " << clan.getDatumRegistracije() << endl;
    COUT << "Spol: " << (clan.getSpol() ? "Muski" : "Zenski") << endl;
    return COUT;
}

// Z2.9 :: operator == [Porediti clanove 'c1' i 'c2' po korisnickom imenu]
bool operator ==(const Clan& c1, const Clan& c2) {
    return strcmp(c1.getKorisnickoIme(), c2.getKorisnickoIme()) == 0;
}

class Post {
    char* _postId = nullptr;
    char* _korisnickoIme = nullptr; //  _korisnickoIme clana foruma koji je objavio post
    Datum _datumObjavljivanja;
    char* _sadrzaj = nullptr;
    //  staticki atribut
    static int _postIdCounter;
public:

    // Z3.1 :: getteri
    const char* getPostId() const { return (_postId == nullptr) ? "" : _postId; }
    const char* getKorisnickoIme() const { return (_korisnickoIme == nullptr) ? "" : _korisnickoIme; }
    Datum getDatumObjavljivanja() const { return _datumObjavljivanja; }
    const char* getSadrzaj() const { return (_sadrzaj == nullptr) ? "" : _sadrzaj; }
    // staticka funkcija [vraca vrijednost brojaca i uvecava ga za 1
    static int getNextId() { return Post::_postIdCounter++; }

    // Z3.2 :: setteri
    // settovati '_postId' na vrijednost konverzije rezultata staticke funkcije 'getNextId' u tip char* [funkcija IntToStr]
    void setPostId() {
        delete[] _postId;
        _postId = intToStr(Post::getNextId());
    }
    void setKorisnickoIme(const char* korisnickoIme) {
        delete[] _korisnickoIme;
        _korisnickoIme = alocirajTekst(korisnickoIme);
    }
    void setDatumObjavljivanja(Datum d) {
        _datumObjavljivanja = d; //  Datum::operator =
    }
    void setSadrzaj(const char* sadrzaj) {
        delete[] _sadrzaj;
        _sadrzaj = alocirajTekst(sadrzaj);
    }


    // Z3.3 :: dflt ctor
    Post() {
    }
    // Z3.4 :: Za inicijalizaciju _postId iskoristiti setter funkciju 'setPostId'
    Post(const char* korisnickoIme, Datum datumO, const char* sadrzaj)
    {
        setPostId();
        setKorisnickoIme(korisnickoIme);
        setDatumObjavljivanja(datumO);
        setSadrzaj(sadrzaj);
    }

    // Z3.5 :: Za inicijalizaciju _postId iskoristiti setter funkciju 'setPostId'
    Post(const Post& obj) {
        setPostId();
        setKorisnickoIme(obj.getKorisnickoIme());
        setDatumObjavljivanja(obj.getDatumObjavljivanja());
        setSadrzaj(obj.getSadrzaj());
    }

    // Z3.6 :: operator dodjele
    Post& operator = (const Post& obj) {
        if (this != &obj) {
            setKorisnickoIme(obj.getKorisnickoIme());
            setDatumObjavljivanja(obj.getDatumObjavljivanja());
            setSadrzaj(obj.getSadrzaj());
        }
        return *this;
    }

    // Z3.7 :: dtor
    ~Post() {
        delete[] _postId, delete[] _korisnickoIme, delete[] _sadrzaj;
    }
};
int Post::_postIdCounter = 1000; //  Inicijalizacija statickog atributa

// Z3.8 :: Ispisati podatke o postu
ostream& operator <<(ostream& COUT, const Post& p) {
    COUT << "Post ID: " << p.getPostId() << endl;
    COUT << "Korisnicko ime: " << p.getKorisnickoIme() << endl;
    COUT << "Datum objavljivanja: " << p.getDatumObjavljivanja() << endl;
    COUT << "Sadrzaj: " << p.getSadrzaj() << endl;
    return COUT;
}

const int maxBrojPostova = 100;
class Sekcija {
    char* _naziv = nullptr;
    char* _kratakOpis = nullptr;
    int _trenutnoPostova = 0;
    Post* _postovi[maxBrojPostova] = { nullptr };
public:
    // Z4.1 :: getteri
    const char* getNaziv() const { return (_naziv == nullptr) ? "" : _naziv; }
    const char* getKratakOpis() const { return (_kratakOpis == nullptr) ? "" : _kratakOpis; }
    int getTrenutnoPostova() const { return _trenutnoPostova; }
    Post** getPostovi() const { return (Post**)_postovi; }
    Post getPostAtI(int index) const { return *_postovi[index]; }

    // Z4.2 :: setteri
    void setNaziv(const char* naziv) {
        delete[]_naziv;
        _naziv = alocirajTekst(naziv);
    }
    void setKratakOpis(const char* kratakOpis) {
        delete[]_kratakOpis;
        _kratakOpis = alocirajTekst(kratakOpis);
    }
    // Setter za niz pokazivaca '_postovi'.
    void setPostovi(int trenutnoPostova, Post** postovi = nullptr) {
        for (int i = 0; i < _trenutnoPostova; i++) {
            delete _postovi[i];
            _postovi[i] = nullptr;
        }
        _trenutnoPostova = 0;
        if (postovi != nullptr)
            for (int i = 0; i < trenutnoPostova; i++)
                dodajPost(*postovi[i]);
    }
    // Z4.3 :: Dflt. ctor
    Sekcija() {
    }
    // Z4.4 :: User-def. ctor
    Sekcija(const char* naziv, const char* kratakOpis) {
        setNaziv(naziv);
        setKratakOpis(kratakOpis);
    }
    // Z4.5 :: Copy ctor
    Sekcija(const Sekcija& obj) {
        setNaziv(obj.getNaziv());
        setKratakOpis(obj.getKratakOpis());
        setPostovi(obj.getTrenutnoPostova(), obj.getPostovi());
    }

    // Z4.6 :: operator dodjele
    Sekcija& operator = (const Sekcija& obj) {
        if (this != &obj) {
            setNaziv(obj.getNaziv());
            setKratakOpis(obj.getKratakOpis());
            setPostovi(obj.getTrenutnoPostova(), obj.getPostovi());
        }
        return *this;
    }

    // Z4.7 :: dodajPost
    // Dodati novi post u niz pokazivaca
    // Onemoguciti dodavanje u slucaju da je popunjen niz pokazivaca
    bool dodajPost(Post& p) {
        if (_trenutnoPostova == maxBrojPostova)
            return false;
        _postovi[_trenutnoPostova] = new Post(p);
        _trenutnoPostova++;
        return true;
    }

    // Z4.8 :: dtor
    ~Sekcija() {
        delete[]_naziv, delete[] _kratakOpis;
        for (int i = 0; i < _trenutnoPostova; i++)
            delete _postovi[i];
    }
};

// Z4.9 :: Ispisati podatke o sekciji [ukljucujuci i postove]
ostream& operator << (ostream& COUT, const Sekcija& obj) {
    COUT << "Naziv sekcije: " << obj.getNaziv() << endl;
    COUT << "Kratak opis: " << obj.getKratakOpis() << endl;
    COUT << "Broj postova: " << obj.getTrenutnoPostova() << endl;
    for (int i = 0; i < obj.getTrenutnoPostova(); i++)
    {
        cout << "----------------------------------------\n";
        cout << obj.getPostAtI(i);
    }
    return COUT;
}

const int maxBrojSekcija = 20;
class Forum {
    char* _naziv = nullptr;
    int _trenutnoSekcija = 0;
    Sekcija _sekcije[maxBrojSekcija];
    int _maxClanova;
    Clan* _clanovi = nullptr;
    int _trenutnoClanova = 0;
public:

    // Z5.1 :: getteri
    const char* getNaziv() const { return (_naziv == nullptr) ? "" : _naziv; }
    // getteri za sekcije
    int getTrenutnoSekcija() const { return _trenutnoSekcija; }
    Sekcija* getSekcije() const { return (Sekcija*)_sekcije; }
    Sekcija getSekcijaAtI(int index) const { return _sekcije[index]; }
    // getteri za clanove
    int getTrenutnoClanova() const { return _trenutnoClanova; }
    int getMaxBrojClanova() const { return _maxClanova; }
    Clan* getClanovi() const { return _clanovi; }
    Clan getClanAtI(int index) const { return _clanovi[index]; }


    // Z5.2 :: setteri
    void setNaziv(const char* naziv) {
        delete[] _naziv;
        _naziv = alocirajTekst(naziv);
    }
    void setSekcije(int trenutnoSekcija, Sekcija* sekcije = nullptr) {
        _trenutnoSekcija = 0;
        if (sekcije != nullptr)
            for (int i = 0; i < trenutnoSekcija; i++)
                dodajSekciju(sekcije[i]);
    }
    void setClanovi(int trenutnoClanova, int maxClanova, Clan* clanovi = nullptr) {
        delete[] _clanovi;
        _maxClanova = maxClanova;
        _clanovi = new Clan[_maxClanova];
        _trenutnoClanova = 0;
        if (clanovi != nullptr)
            for (int i = 0; i < trenutnoClanova; i++)
                dodajClana(clanovi[i]);
    }
    // Z5.3 :: User-def. ctor
    Forum(const char* naziv, int maxClanova) {
        setNaziv(naziv);
        setClanovi(0, maxClanova);
    }
    // Z5.4 :: Copy ctor
    Forum(const Forum& obj) {
        setNaziv(obj.getNaziv());
        setSekcije(obj.getTrenutnoSekcija(), obj.getSekcije());
        setClanovi(obj.getTrenutnoClanova(), obj.getMaxBrojClanova(), obj.getClanovi());
    }

    // Z5.5 :: funkcija za dodavanje nove sekcije
    bool dodajSekciju(const Sekcija sekcija) {
        if (_trenutnoSekcija == maxBrojSekcija)
            return false;
        _sekcije[_trenutnoSekcija] = sekcija; //  Sekcija::operator = 
        _trenutnoSekcija++;
        return true;
    }

    // Z5.6 :: funkcija za dodavanje novog clana
    // Ukoliko brojac dosegne vrijednost '_maxClanova', uraditi prosirivanje niza za 10 koristenjem metode 'expandClanovi'
    void dodajClana(const Clan clan) {
        if (_trenutnoClanova == _maxClanova)
            expandClanovi(10);
        _clanovi[_trenutnoClanova] = clan; //  Clan::operator = 
        _trenutnoClanova++;
    }

    // Z5.7 :: funkcija za prosirivanje dinamickog niza '_clanovi'
    void expandClanovi(int uvecanje) {
        if (uvecanje <= 0)
            return;
        Clan* temp = _clanovi;
        _clanovi = new Clan[_maxClanova + uvecanje];
        for (int i = 0; i < _maxClanova; i++)
            _clanovi[i] = temp[i];
        _maxClanova += uvecanje;
        delete[] temp;
    }

    // Z5.8 :: dtor
    ~Forum() {
        delete[] _naziv, delete[] _clanovi;
    }

};

// Z5.9 :: Ispisati podatke o forumu, ispisati sekcije [zajedno sa postovima] te korisnicka imena forumasa [clanova]
ostream& operator <<(ostream& COUT, const Forum& f) {
    COUT << "Forum: " << f.getNaziv() << endl;
    COUT << "Broj sekcija: " << f.getTrenutnoSekcija() << endl;
    for (int i = 0; i < f.getTrenutnoSekcija(); i++)
        COUT << "[" << endl << f.getSekcijaAtI(i) << "] " << endl;
    COUT << "Broj forumasa: " << f.getTrenutnoClanova() << endl;
    for (int i = 0; i < f.getTrenutnoClanova(); i++)
        COUT << f.getClanAtI(i).getKorisnickoIme() << ",";
    COUT << endl;
    return COUT;
}
void zadatak1() {
    cout << "Sve prijestupne godine izmedju [1900-2023]: " << endl;
    for (int i = 1900; i <= 2023; i++)
        if (prijestupnaGodina(i))
            cout << i << ", ";
    cout << endl;
    Datum starWarsDay; // dflt. ctor
    starWarsDay.setDan(4);
    starWarsDay.setMjesec(5);
    starWarsDay.setGodina(2023);
    cout << "Star Wars day: " << starWarsDay << endl; //  operator <<

    Datum worldUfoDay(starWarsDay.getDan() - 3, starWarsDay.getMjesec() + 2, starWarsDay.getGodina()); // user-def. ctor
    cout << "World Ufo day: " << worldUfoDay << endl;

    Datum laborDay(starWarsDay); // copy ctor
    laborDay.setDan(1);
    cout << "Labor day (BiH): " << laborDay << endl;

    Datum juneSolstice(21, 6, 2023), juneSolstice_copy;
    juneSolstice_copy = juneSolstice;
    cout << "June Solstice (BiH): " << juneSolstice << endl;

    Datum datumi[] = { Datum(1,2,2023), Datum(31,12, 2022), Datum(31, 12, 2023) };
    cout << "Razlika u danima: --->" << endl;
    cout << "Razlika izmedju: " << datumi[0] << " i " << datumi[1] << " je " << datumi[0] - datumi[1] << endl; //  operator -
    cout << "Razlika izmedju: " << datumi[0] << " i " << datumi[2] << " je " << datumi[0] - datumi[2] << endl; //  operator -
    cout << "Razlika izmedju: " << datumi[1] << " i " << datumi[2] << " je " << datumi[1] - datumi[2] << endl; //  operator -

    // Testiranje operatora +
    Datum someDatum(5, 5, 2025);
    cout << "Test datum: " << someDatum << endl;
    cout << someDatum << " + 30 dana  = " << someDatum + 30 << endl; //  operator +
    cout << "Dealokacija..." << endl;
}

void zadatak2() {
    Clan almightyBruce;
    almightyBruce.setKorisnickoIme("almightyBruce");
    almightyBruce.setDatumRegistracije(Datum(1, 1, 2023));
    almightyBruce.setSpol(0);
    almightyBruce.setSpol(1);
    almightyBruce.setLozinka("it's Gooooooooood");
    cout << almightyBruce << endl;

    Clan crazyMage("CrazyMage", "PA$$w0rd", Datum(3, 12, 2019), 1);
    Clan copyCrazyMage(crazyMage);
    cout << copyCrazyMage << endl;

    Clan azermyth("Azermyth", "azerpass", Datum(1, 4, 2022), 1);
    cout << azermyth << endl;
    cout << "Testiranje operatora '==' " << endl;
    cout << (crazyMage == copyCrazyMage ? "Isti clan!" : "Razlici clanovi!") << endl;

    Clan aceVentura;
    aceVentura = azermyth;
    aceVentura.setKorisnickoIme("8Ventura");
    aceVentura.setDatumRegistracije(Datum(1, 6, 2022));
    cout << aceVentura << endl;
    cout << "Dealokacija..." << endl;
}
void zadatak3() {
    Post p1;
    p1.setPostId();
    p1.setKorisnickoIme("Neo");
    p1.setDatumObjavljivanja(Datum(5, 5, 2023));
    p1.setSadrzaj("Izasao sam iz matrice. Osjecaj je prelijep...");
    cout << p1 << endl;

    Post p2("Trinity", Datum(5, 5, 2023), " Kolega @Neo, you don't say.");
    Post copyp2(p2);
    cout << copyp2 << endl;

    Post p3("Ementaler", Datum(6, 5, 2023), "Pozdrav ljudi. Ovdje Igor sa Hcl-a...");
    cout << p3 << endl;

    Post p4;
    p4 = p3;
    p4.setPostId();
    p4.setKorisnickoIme("Agent Smith");
    p4.setSadrzaj("Dragi kolega @Neo, pripremite se da vas dealociram.");
    cout << p4 << endl;
    cout << "Dealokacija..." << endl;
}

void zadatak4() {
    Sekcija letNaMars("Let na mars, all about...", "Neki opis...");
    Post p1("bad_karma13", Datum(2, 3, 2023), "Ispucao je losu srecu na Cybertrucku.. Ovo uspijeva 100%");
    Post p2("monkey_see_monkey_do", Datum(3, 3, 2023), "Kad ono uzlijece Elon sa svojima? xD");
    Post p3("cerealKillerHoho", Datum(3, 3, 2023), "Teraformiranje Marsa ce se pokazati kao prevelik zalogaj za nasu generaciju...");
    Post p4("dr_Michio_Kaku", Datum(3, 3, 2023), "Ovo je prvi korak u kolonizaciji Suncevog sistema...");
    Post p5("superSonic", Datum(3, 3, 2023), "Zelimo novo gostovanje g.Muska kod Joe Rogena!");
    letNaMars.dodajPost(p1);
    letNaMars.dodajPost(p2);
    letNaMars.dodajPost(p3);
    Sekcija mars2(letNaMars);
    mars2.dodajPost(p4);
    mars2.dodajPost(p5);
    Sekcija mars3;
    mars3 = mars2;
    cout << mars3 << endl;
    cout << "Dealokacija..." << endl;
}

void zadatak5() {
    Forum nebula("Nebula:: forum o fizici i metafizici", 10);
    Clan arwen_dor("arwenix", "L0trI$L1fe", Datum(11, 1, 2023), 0);
    Clan thomasAnderson("neo", "one", Datum(12, 1, 2023), 1);
    Clan rickC_137("rickestRick", "Waba-Luba-Dub-Dub", Datum(3, 3, 2023), 1);

    // Dodavanje clanova na forum 'nebula'
    nebula.dodajClana(arwen_dor);
    nebula.dodajClana(thomasAnderson);
    nebula.dodajClana(rickC_137);
    // sekcija 1
    Sekcija newAge("New Age", "Sta predstavlja New Age?");
    Post p1("arwenix", Datum(3, 3, 2023), "Postoji niz proturijecnih definicija o novom fenomenu ...");
    Post p2("neo", Datum(4, 3, 2023), "Nova religija? Ili ipak samo nova paradigma? ...");
    Post p3("rickestRick", Datum(5, 3, 2023), "Ovisi od konteksta u kojem se pojavljuje");
    newAge.dodajPost(p1); //  dodavanje posta
    newAge.dodajPost(p2); //  dodavanje posta
    newAge.dodajPost(p3); //  dodavanje posta
    // sekcija 2
    Sekcija telepatija("Telepatija i telekineza", "Parapsiholoski fenomeni");
    Post p4("arwenix", Datum(6, 3, 2023), "Na ovom podrucju najvise se proslavio Uri Geller ...");
    Post p5("neo", Datum(7, 3, 2023), "Medju poznatije slucajeve ubraja se i Nina Kulagina...");
    telepatija.dodajPost(p4); //  dodavanje posta
    telepatija.dodajPost(p5); //  dodavanje posta
    // dodavanje sekcija na forum
    nebula.dodajSekciju(newAge); //  dodavanje sekcije
    nebula.dodajSekciju(telepatija); //  dodavanje sekcije
    // kopiranje i premjestanje objekta tipa 'Forum'
    Forum copy_of_nebula(nebula);
    cout << copy_of_nebula;
    cout << "Dealokacija..." << endl;
}

void menu() {
    int nastaviDalje = 1;
    while (nastaviDalje == 1) {
        int izbor = 0;
        do {
            system("cls");
            cout << "::Zadaci::" << endl;
            cout << "(1) zadatak 1" << endl;
            cout << "(2) zadatak 2" << endl;
            cout << "(3) zadatak 3" << endl;
            cout << "(4) zadatak 4" << endl;
            cout << "(5) zadatak 5" << endl;
            cout << "Unesite odgovarajuci broj zadatka za testiranje: -->: ";
            cin >> izbor;
            cout << endl;
        } while (izbor < 1 || izbor > 5);
        switch (izbor) {
        case 1: zadatak1(); cout << "zadatak 1. Done." << endl; break;
        case 2: zadatak2(); cout << "zadatak 2. Done." << endl; break;
        case 3: zadatak3(); cout << "zadatak 3. Done." << endl; break;
        case 4: zadatak4(); cout << "zadatak 4. Done." << endl; break;
        case 5: zadatak5(); cout << "zadatak 5. Done." << endl; break;
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