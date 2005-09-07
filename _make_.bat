@echo off
rem =======================================================
rem Client SSI Generator makefile
rem Copyright ©2001-2003 Dmitry Kann, http://devtools.narod.ru
rem =======================================================

rem -B = Rebuild all
rem -W = Output warning messages
rem -H = Output hint messages
set OPTIONS=-B -W -H
set SWITCHES=A8B-C-D-G+H+I+J-L-M-O+P+Q-R-T-U-V+W-X+Y-Z1
set DELPHI=C:\Progra~1\Borland\Delphi7
set LIBRARY_PATH=%DELPHI%\tb2k\Source;%DELPHI%\tbx;%DELPHI%\GraphicEx;%DELPHI%\Graphics32;%DELPHI%\RX;%DELPHI%\RX\Units;%DELPHI%\vtv\Source;%DELPHI%\vst\Source
set COMPILER=%DELPHI%\Bin\dcc32.exe

set HELP_COMPILER="C:\Program Files\HTML Help Workshop\hhc.exe"

set SETUP_COMPILER="C:\Program Files\Inno Setup 5\iscc.exe"

rem == Compile Delphi DPR project ==
echo.
echo == Compile Delphi DPR project ==
%COMPILER% clssigen.dpr %OPTIONS% -$%SWITCHES% -U%LIBRARY_PATH%
if errorlevel == 1 goto :err
del *.~*
del *.dcu
del *.ddp
del *.bkf
del *.bkm
del GraphicEx\*.dcu

rem == Compile Help CHM project ==
echo.
echo == Compile Help CHM project (en)
cd Help\en
%HELP_COMPILER% cssigen-en.hhp
if not errorlevel == 1 goto :err
move cssigen-en.chm ..\..
if errorlevel == 1 goto :err

echo.
echo == Compile Help CHM project (ru)
cd ..\ru
%HELP_COMPILER% cssigen-ru.hhp
if not errorlevel == 1 goto :err
move cssigen-ru.chm ..\..
if errorlevel == 1 goto :err
cd  ..\..

rem == Compile Installation ISS script ==
echo.
echo == Compile Installation ISS script ==
cd IS-Install
%SETUP_COMPILER% clssigen.iss
if errorlevel == 1 goto :err
goto :success
:err
pause
:success