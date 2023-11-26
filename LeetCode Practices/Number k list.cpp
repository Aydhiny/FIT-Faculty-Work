#include <iostream>
#include <vector>
const char* crt = "----------------------------\n";
using namespace std;

vector<int> poredajVector(vector<int>);
bool pronadjiBroj(vector<int>, int);
ostream& operator<<(ostream& COUT, const vector<int>& obj)
{
    for (size_t i = 0; i < obj.size(); i++)
    {
        COUT << obj[i] << " | ";
    }
    COUT << endl;
    return COUT;
}
//Given a list of numbers and a number k, return whether any two numbers from the list add up to k.
//For example, given[10, 15, 3, 7] and k of 17, return true since 10 + 7 is 17.

int main() 
{
    vector<int> numbers = { 10, 15, 3, 7 };
    cout << numbers;
    int k, pronadjeniBroj;
	cout << "Unesite vrijednost k: ";
    cin >> k;
    vector<int> br2 = poredajVector(numbers);
    cout << (pronadjiBroj(br2, k) ? "BROJ PRONADJEN" : "BROJ NIJE U NIZU!");
	return 0;
}

vector<int> poredajVector(vector<int> numbers) 
{
    int n = numbers.size();

    for (int i = 0; i < n - 1; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (numbers[j] > numbers[j + 1]) {
                // Swap if the element found is greater than the next element
                std::swap(numbers[j], numbers[j + 1]);
            }
        }
    }
    return numbers;
}

bool pronadjiBroj(vector<int> numbers, int k) 
{
    for (int i = 0; i < numbers.size() - 1; i++)
    {
        if (numbers[i] + numbers[i + 1] == k)
            return true;
    }
    return false;
}
