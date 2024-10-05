#include <iostream>
#include <vector>
#include <string>

using namespace std;

const char* crt = "---------------------------\n";
class Actor {
public:
    Actor(const string& name) : name(name) {}

    string getName() const {
        return name;
    }

private:
    string name;
};

class Director {
public:
    Director(const string& name) : name(name) {}

    string getName() const {
        return name;
    }

private:
    string name;
};

class Genre {
public:
    Genre(const string& name) : name(name) {}

    string getName() const {
        return name;
    }

private:
    string name;
};

class Movie {
public:
    Movie(const string& title, int year, const Director& director, const vector<Actor>& actors, const Genre& genre)
        : title(title), year(year), director(director), actors(actors), genre(genre), rating(0) {}

    void rate(int userRating) {
        if (userRating >= 1 && userRating <= 5) {
            ratings.push_back(userRating);
            updateRating();
        }
        else {
            cout << "Invalid rating. Please enter a rating between 1 and 5." << endl;
        }
    }

    void displayInfo() const {
        cout << "Ratings are going from 1 to 5. \n";
        cout << "Title: " << title << endl;
        cout << "Year: " << year << endl;
        cout << "Director: " << director.getName() << endl;
        cout << "Actors: ";
        for (const Actor& actor : actors) {
            cout << actor.getName() << ", ";
        }
        cout << endl;
        cout << "Genre: " << genre.getName() << endl;
        cout << "Average Rating: " << rating << " (based on " << ratings.size() << " ratings)" << endl;
    }

private:
    string title;
    int year;
    Director director;
    vector<Actor> actors;
    Genre genre;
    vector<int> ratings;

    double rating;

    void updateRating() {
        if (!ratings.empty()) {
            int sum = 0;
            for (int userRating : ratings) {
                sum += userRating;
            }
            rating = static_cast<double>(sum) / ratings.size();
        }
    }
};

int main() {
    Actor actor1("Tom Cruise");
    Actor actor2("Scarlett Johansonn");
    Actor actor3("Chris Pratt");
    Director director("Christopher Nolan");
    Director director2("Scott Jr");
    Genre genre("Horror");
    Genre genre1("Comedy");
    Genre genre2("Action");

    vector<Movie> movies;

    // Add some movies to the database
    movies.emplace_back("Mission Impossible Dead Reckoning", 2020, director, vector<Actor>{actor1, actor2, actor3}, genre2);
    movies.emplace_back("Top Gun: Maverick", 2019, director2, vector<Actor>{actor1, actor3}, genre1);

    // Rate a movie
    movies[0].rate(4);
    movies[0].rate(5);
    movies[0].rate(2);
    movies[0].rate(1);

    movies[1].rate(5);
    movies[1].rate(5);
    movies[1].rate(5);
    movies[1].rate(4);
    movies[1].rate(3);

    // Display movie information
    movies[0].displayInfo();
    cout << crt;
    movies[1].displayInfo();

    return 0;
}
