@echo off

echo.
echo -- Creating temporary directory
echo.

mkdir tmp\

echo.
echo -- Copying needed assets
echo.

cp -rf .\input\assets .\tmp\assets

echo.
echo -- Start loop
echo.

for %%a in (".\input\*.md") do call :Pandoc %%~na
goto End

:Pandoc
set name=%1
echo [%name%] Mardown to Tex conversion through Pandoc
pandoc .\input\%name%.md -o .\tmp\%name%.tex --filter .\resources\filter\pandoc-minted.py --no-highlight --template=.\resources\template\custom.tex --top-level-division=section
cp .\tmp\%name%.tex .\output\%name%.tex
call :Xelatex %name%
goto :eof

:Xelatex
set name=%1
echo [%name%] Pdf generation conversion with Xelatex
cd .\tmp\
xelatex %name%.tex --shell-escape
xelatex %name%.tex --shell-escape
cp %name%.pdf ..\output\%name%.pdf
cd ..\
goto :eof

:End

echo.
echo -- Removing temporary files
echo.

rm tmp\ -r