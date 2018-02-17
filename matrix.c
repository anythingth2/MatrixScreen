#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>
#include <windows.h>

int WHITE =0xF;
int GRAY =0x8;
int GREEN =0xA;
int DARK_GREEN =0x2;

typedef struct _matrix
{
    int x;
    int y;
    int length;
} Matrix;

Matrix matrix[80];
const int numMatrix = 80;

void gotoxy(int x, int y);
void setTextColor(int color);
void printCharAt(int x, int y);
void clearCharAt(int x, int y);

void printFlowMatrix(Matrix matrix)
{

    for (int i = 0; i < matrix.length; i++)
    {
        int y = matrix.y - i;
        if (y >= 0 && y < 25)
        {
            if (i == 0)
                setTextColor(WHITE);
            else if (i < 2)
                setTextColor(GRAY);
            else if (i < matrix.length - 2)
                setTextColor(GREEN);
            else
                setTextColor(DARK_GREEN);

            printCharAt(matrix.x, matrix.y - i);
        }
    }
}

int randomNumber(int from, int to);

Matrix initMatrix()
{
    Matrix m;
    m.x = randomNumber(0, 80);
    m.y = randomNumber(-50, 0);
    m.length = randomNumber(10, 20);
    return m;
}

void initAllMatrix()
{
    for (int i = 0; i < numMatrix; i++)
    {
        matrix[i] = initMatrix();
    }
}

void updateAllMatrix()
{
    // system("cls");
    for (int i = 0; i < numMatrix; i++)
    {
        clearCharAt(matrix[i].x, matrix[i].y - matrix[i].length);
        matrix[i].y++;

        int matrixTail = matrix[i].y - matrix[i].length;
        if (matrix[i].y >= 0 && matrixTail < 25)
        {
            printFlowMatrix(matrix[i]);
        }
        else if (matrixTail >= 25)
        {
            matrix[i] = initMatrix();
        }
    }
}

int main()
{
    system("cls");
    initAllMatrix();

    for (;;)
    {
        updateAllMatrix();
        Sleep(50);
    }
    return 0;
}
void gotoxy(int x, int y)
{
    COORD coord;
    coord.X = x;
    coord.Y = y;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
}

void setTextColor(int color)
{
    HANDLE hConsole;
    hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

    SetConsoleTextAttribute(hConsole, color);

    // textcolor(color);
}
void printCharAt(int x, int y)
{
    gotoxy(x, y);

    printf("%c", randomNumber(33, 126));
}

void clearCharAt(int x, int y)
{
    gotoxy(x, y);
    printf(" ");
}

int randomNumber(int from, int to)
{
    // srand(time(NULL));

    return rand() % (to - from) + from;
}