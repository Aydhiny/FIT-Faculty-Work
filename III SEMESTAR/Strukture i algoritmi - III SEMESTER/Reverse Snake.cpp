#include <iostream>
#include <cstdlib>
#include <ctime>
#include <conio.h> // for _getch() function (Windows specific)

using namespace std;

const int width = 20;
const int height = 20;

bool gameOver;
int snakeX, snakeY, foodX, foodY, score;

enum Direction { STOP = 0, LEFT, RIGHT, UP, DOWN };
Direction dir;

void Setup() {
    gameOver = false;
    dir = STOP;
    snakeX = width / 2;
    snakeY = height / 2;
    foodX = rand() % width;
    foodY = rand() % height;
    score = 0;
}

void Draw() {
    system("cls"); // Clear the screen
    for (int i = 0; i < width + 2; i++)
        cout << "#";
    cout << endl;

    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            if (j == 0)
                cout << "#";
            if (i == snakeY && j == snakeX)
                cout << "O";
            else if (i == foodY && j == foodX)
                cout << "F";
            else
                cout << " ";
            if (j == width - 1)
                cout << "#";
        }
        cout << endl;
    }

    for (int i = 0; i < width + 2; i++)
        cout << "#";
    cout << endl;
    cout << "Score:" << score << endl;
}

void Input() {
    if (_kbhit()) {
        switch (_getch()) {
        case 'a':
            dir = LEFT;
            break;
        case 'd':
            dir = RIGHT;
            break;
        case 'w':
            dir = UP;
            break;
        case 's':
            dir = DOWN;
            break;
        case 'x':
            gameOver = true;
            break;
        }
    }
}

void Logic() {
    switch (dir) {
    case LEFT:
        snakeX--;
        break;
    case RIGHT:
        snakeX++;
        break;
    case UP:
        snakeY--;
        break;
    case DOWN:
        snakeY++;
        break;
    default:
        break;
    }
    if (snakeX >= width) snakeX = 0; else if (snakeX < 0) snakeX = width - 1;
    if (snakeY >= height) snakeY = 0; else if (snakeY < 0) snakeY = height - 1;

    if (snakeX == foodX && snakeY == foodY) {
        score++;
        foodX = rand() % width;
        foodY = rand() % height;
    }
}

int main() {
    srand(time(0)); // Seed random number generator
    Setup();
    while (!gameOver) {
        Draw();
        Input();
        Logic();
    }
    return 0;
}