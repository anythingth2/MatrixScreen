@echo off

del MATRIX.OBJ
del MATRIX.COM
del MATRIX.MAP

tasm matrix.asm

if EXIST "MATRIX.OBJ"  tlink MATRIX.OBJ /t
REM if EXIST "MATRIX.COM"  cls  
if EXIST "MATRIX.COM" MATRIX.COM
echo.
