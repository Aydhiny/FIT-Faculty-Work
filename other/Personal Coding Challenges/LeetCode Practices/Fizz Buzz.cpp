#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> fizzBuzz(int n) {

        vector<string> store;

        for (int i = 1; i < n + 1; i++) 
        {
            if (i % 3 == 0 && i % 5 == 0)
                store.push_back("FizzBuzz");
            else if (i % 3 == 0)
                store.push_back("Fizz");
            else if (i % 5 == 0)
                store.push_back("Buzz");
            else 
            {

                store.push_back(to_string(i));
            }
        }
        return store;
    }
};

int main() 
{
  return 0;
}
