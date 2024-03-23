#include <iostream>
using namespace std;

int main() {
    int input[100], count, i, nCount = 0, pCount = 0, zCount = 0;

    cout << "Enter Number of Elements in Array\n";
    cin >> count;

    cout << "Enter " << count << " numbers \n";

    for (i = 0; i < count; i++) {
        cin >> input[i];
    }

    for (i = 0; i < count; i++) {
        if (input[i] < 0) {
            nCount++;
        }
        else if (input[i] > 0) {
            pCount++;
        }
        else {
            zCount++;
        }
    }

    cout << "Negative Numbers : " << nCount << endl;
    cout << "Positive Numbers : " << pCount << endl;
    cout << "Zeroes : " << zCount << endl;

    return 0;
}
