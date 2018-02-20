@echo off

del TEST.OBJ
del TEST.COM
del TEST.MAP

tasm TEST.asm

if EXIST "TEST.OBJ"  tlink TEST.OBJ /t
if EXIST "TEST.COM"  cls  
if EXIST "TEST.COM" TEST.COM
echo.
