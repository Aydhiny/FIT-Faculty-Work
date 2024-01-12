#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

bool isPrime(int br) 
{
    if(br < 2)
        return false;
    for(int i = 2; i <= sqrt(br); i++) {
        if(br % i == 0)
            return false;
    }
    return true;
}

int main()
{
    int x;
    cin >> x; cin.ignore();
    int current = x + 1;
    while(!isPrime(current))
        current++;
    // Write an answer using cout. DON'T FORGET THE "<< endl"
    // To debug: cerr << "Debug messages..." << endl;

    cout << current << endl;
}
