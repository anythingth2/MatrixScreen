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

int matrixY[80];
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
    
void printFlowMatrix(int x,int matrixY)
{

    for (int i = 0; i < 15; i++)
    {
        int y = matrixY - i;
        if (y >= 0 && y < 25)
        {
            setTextColor(matrixColorCode[i]);
            printCharAt(x, matrixY - i);
        }
    }
}


void initAllMatrix()
{
    for (int i = 0; i < numMatrix; i++)
        matrixY[i] = randomNumber(100, 150);
}

void updateAllMatrix()
{
    for (int i = 0; i < numMatrix; i++)
    {
        if (matrixY[i] < 150)
            matrixY[i]++;
        else
            matrixY[i] = 0;

        if (matrixY[i] < 40)
            printFlowMatrix(i,matrixY[i]);
        else if (matrixY[i] == 40)
            matrixY[i] = randomNumber(100, 150);
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

int randomNumber(int from, int to)
{
    return rand() % (to - from) + from;
}