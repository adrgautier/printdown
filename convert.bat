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

for %%a in (".\input\*.md") do call :Retext %%~na
goto End

:Remark
set name=%1
echo [%name%] Markdown processing through Remark
call remark .\input\%name%.md --rc-path=remark.json
call :Pandoc %name%
goto :eof

:Retext
set name=%1
echo [%name%] Markdown processing through Retext
call node retext.js --input=%name%.md
cp .\tmp\%name%.md .\output\%name%.md
call :Pandoc %name%
goto :eof

:RemarkByPass
set name=%1
echo [%name%] Markdown processing through Remark
cp .\input\%name%.md .\tmp\%name%.md
call :Pandoc %name%
goto :eof


:Pandoc
set name=%1
echo [%name%] Mardown to Tex conversion through Pandoc
pandoc .\tmp\%name%.md -o .\tmp\%name%.tex --filter .\resources\filter\pandoc-minted.py --no-highlight --template=.\resources\template\custom.tex --top-level-division=section
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