@echo off

echo.
echo -- Creating temporary directory
echo.

mkdir tmp\

echo.
echo -- Copying needed packages
echo.

cp .\resources\emoji\emojione.sty .\tmp\emojione.sty

echo.
echo -- Start loop
echo.

for %%a in (".\input\*.md") do call :Remark %%~na
REM for %%a in (".\tmp\*.md") do call :Pandoc %%~na
REM for %%a in (".\tmp\*.tex") do call :Xelatex %%~na
goto End

:Remark
set name=%1
echo [%name%] Markdown processing through Remark
call remark .\input\%name%.md --rc-path=remark.json
call :Pandoc %name%
goto :eof

:Pandoc
set name=%1
echo [%name%] Mardown to Tex conversion through Pandoc
pandoc .\tmp\%name%.md -o .\tmp\%name%.tex --filter .\resources\filter\pandoc-minted.py --no-highlight --template=.\resources\template\custom.tex
call :Xelatex %name%
goto :eof

:Xelatex
set name=%1
echo [%name%] Pdf generation conversion with Xelatex
cd .\tmp\
xelatex %name%.tex --shell-escape
cp %name%.pdf ..\output\%name%.pdf
cd ..\

goto :eof

:End

echo.
echo -- Removing temporary files
echo.

rm tmp\ -r