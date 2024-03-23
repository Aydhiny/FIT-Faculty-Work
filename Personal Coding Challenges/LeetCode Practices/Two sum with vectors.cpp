#include <iostream>
#include <vector>
const char* crt = "----------------------------\n";
using namespace std;

ostream& operator<<(ostream& COUT, const vector<int>& obj)
{
    for (size_t i = 0; i < obj.size(); i++)
    {
        COUT << obj[i] << " | ";
    }
    COUT << endl;
    return COUT;
}

vector<int> twoSum(vector<int>& nums, int target)
{
    for (int i = 0; i < nums.size() - 1; i++) {
        for (int j = i + 1; j < nums.size(); j++) {
            if (nums[i] + nums[j] == target)
                return { i, j };
        }
    }
    return {};
}

int main()
{
    vector<int> input = { 8, 4, 5};
    vector<int> result = twoSum(input, 13);

    if (result.empty()) {
        cout << "No solution found." << endl;
    }
    else {
        cout << "Indices of the two numbers that add up to the target: " << result[0] << " and " << result[1] << endl;
    }
    return 0;
}