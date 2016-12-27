@echo off
for %%a in (".\input\emoji_u*.svg") do call :Convert %%~na
goto End

:Convert
set name=%1
set final=%name:emoji_u=%
echo.%final%.pdf
inkscape --without-gui --file=".\input\%1.svg" --export-pdf=".\output\%final%.pdf"
goto :eof

:End