#include <iostream>
#include <queue>
#include <unordered_map>
#include <string>

using namespace std;

struct Node {
    char data;
    unsigned freq;
    Node* left, * right;
    Node(char data, unsigned freq) : data(data), freq(freq), left(nullptr), right(nullptr) {}
};

struct compare {
    bool operator()(Node* l, Node* r) {
        return l->freq > r->freq;
    }
};

void generateCodes(Node* root, string str, unordered_map<char, string>& huffmanCode) {
    if (!root)
        return;
    if (!root->left && !root->right)
        huffmanCode[root->data] = str;
    generateCodes(root->left, str + "0", huffmanCode);
    generateCodes(root->right, str + "1", huffmanCode);
}

unordered_map<char, string> buildHuffmanTree(const string& text) {
    unordered_map<char, unsigned> freqMap;
    for (char c : text)
        freqMap[c]++;

    priority_queue<Node*, vector<Node*>, compare> minHeap;
    for (const auto& pair : freqMap)
        minHeap.push(new Node(pair.first, pair.second));

    while (minHeap.size() != 1) {
        Node* left = minHeap.top();
        minHeap.pop();
        Node* right = minHeap.top();
        minHeap.pop();
        Node* parent = new Node('\0', left->freq + right->freq);
        parent->left = left;
        parent->right = right;
        minHeap.push(parent);
    }

    Node* root = minHeap.top();
    unordered_map<char, string> huffmanCode;
    generateCodes(root, "", huffmanCode);
    return huffmanCode;
}

string encode(const string& text, const unordered_map<char, string>& huffmanCode) {
    string encodedText = "";
    for (char c : text)
        encodedText += huffmanCode.at(c);
    return encodedText;
}

string decode(const string& encodedText, const unordered_map<char, string>& huffmanCode) {
    string decodedText = "";
    string currentCode = "";
    for (char bit : encodedText) {
        currentCode += bit;
        for (const auto& pair : huffmanCode) {
            if (pair.second == currentCode) {
                decodedText += pair.first;
                currentCode = "";
                break;
            }
        }
    }
    return decodedText;
}

int main() {
    string text = "this is an example for huffman encoding";
    unordered_map<char, string> huffmanCode = buildHuffmanTree(text);
    string encodedText = encode(text, huffmanCode);
    cout << "Encoded text: " << encodedText << endl;
    string decodedText = decode(encodedText, huffmanCode);
    cout << "Decoded text: " << decodedText << endl;
    return 0;
}