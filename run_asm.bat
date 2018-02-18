@echo off

del MATRIX.OBJ
del MATRIX.COM
del MATRIX.MAP

tasm matrix.asm

if EXIST "MATRIX.OBJ"  tlink MATRIX.OBJ /t
if EXIST "MATRIX.OBJ"  cls
if EXIST "MATRIX.OBJ"  MATRIX.COM
