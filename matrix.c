#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>
#include <windows.h>

int WHITE = 0xF;
int GRAY = 0x8;
int GREEN = 0xA;
int DARK_GREEN = 0x2;
int BLACK = 0x0;

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
int randomNumber(int from, int to);

int matrixColorCode[] = {
    WHITE,
    GRAY,
    GREEN,
    DARK_GREEN,
    GREEN,
    GREEN,
    DARK_GREEN,
    GREEN,
    DARK_GREEN,
    GREEN,
    DARK_GREEN,
    GREEN,
    DARK_GREEN,
    DARK_GREEN,
    BLACK
    };
void printFlowMatrix(Matrix matrix)
{

    for (int i = 0; i < matrix.length; i++)
    {
        int y = matrix.y - i;
        if (y >= 0 && y < 25)
        {
            // if (i == 0)
            //     setTextColor(WHITE);
            // else if (i < 2)
            //     setTextColor(GRAY);
            // else if (i < matrix.length - 2)
            //     if (randomNumber(0, 2))
            //         setTextColor(GREEN);
            //     else
            //         setTextColor(DARK_GREEN);
            // else
            //     setTextColor(DARK_GREEN);
            setTextColor(matrixColorCode[i]);

            printCharAt(matrix.x, matrix.y - i);
        }
    }
}

// Matrix initMatrix()
// {

//     Matrix m;
//     m.x = randomNumber(0, 80);
//     m.y = randomNumber(100, 150);
//     m.length = 15;
//     return m;
// }

void initAllMatrix()
{
    for (int i = 0; i < numMatrix; i++)
    {
        matrix[i].x = i;
        matrix[i].y = randomNumber(100, 150);
        matrix[i].length = 15;
    }
}

void updateAllMatrix()
{
    // system("cls");
    for (int i = 0; i < numMatrix; i++)
    {
        if (matrix[i].y < 150)
            matrix[i].y++;
        else
            matrix[i].y = 0;

        if (matrix[i].y < 40)
            printFlowMatrix(matrix[i]);
        else if (matrix[i].y == 40)
            matrix[i].y = randomNumber(100, 150);
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
    return rand() % (to - from) + from;
}