@echo off
del matrix.exe
g++ matrix.c -o matrix.exe

if EXIST matrix.exe (
    cls
    matrix.exe
)