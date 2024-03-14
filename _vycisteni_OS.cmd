@echo off
title [VYCISTENI OS]
color 0a
echo ----------------------------------------------------------------------------------
echo                               SCRIPT PRO VYCISTENI OS
echo                                   pripravil MiRdA   
echo                                     THX tritong  
echo ----------------------------------------------------------------------------------
echo.
echo       ulozte si veskerou rozdelanou praci a ukoncete prosim vsechny programy!           
echo                          Hlavne i u hodin, lista dole vpravo
echo              spoustejte tento skript jako administrator/spravce pocitace!
echo                     pokud se tak nestalo, zavrete okno a provedte!        
echo.
echo off
pause
cls

echo Uklizim v pocitaci prosim chvilku strpeni a budeme pokracovat ...
echo.
echo.
del /s /f /q %systemroot%\*.tmp
del /s /f /q %systemroot%\Temp\*.*
del /s /f /q %appdata%\*.tmp
del /s /f /q %localappdata%\*.tmp
del /s /f /q %programdata%\*.tmp
del /s /f /q %programfiles%\*.tmp
del /s /f /q %programfiles(x86)%\*.tmp
del /s /f /q %TEMP%
del /s /f /q %TMP%
echo.
pause
cls
echo * Dalsi nastaveni pro "NASTROJ VYCISTENI DISKU" a jeho VOLBY
echo.
echo * V nasledujicim otevrenem okne pridejte zatrzitka u vsech dostupnych moznosti krome:
echo.
echo U W10 "Soubory protokolu upgradu systemu Windows" u starsich OS jako W7 "Zalozni soubory aktualizace"
cleanmgr /sageset:1
pause
cls
echo.
echo Nyni nastroj vycisteni pracuje s parametry, ktere jsme pred par okamziky oznacili ...
echo.
echo * Vyckejte prosim do konce cisteni ...
echo.
echo off
cleanmgr /sagerun:1
cls
echo Mazu stare body obnovy...
echo.
echo off
vssadmin delete shadows /for=%systemdrive% /all /quiet
vssadmin resize shadowstorage /for=%systemdrive% /on=%systemdrive% /maxsize=2GB
echo.
echo Provadim posledni nutnejsi upravy OS...
echo.
echo off
bitsadmin /reset /allusers
ipconfig /flushdns
netsh winsock reset all
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\IPSec\Policy\Local /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\IPSec\Policy\Local /f
echo.
pause
cls

title [Resetovani brany firewal]
color 0a
echo --------------------------------------------------------------
echo Mate v umyslu provest resetovani nastaveni brany firewall?.
echo --------------------------------------------------------------
echo.
echo * Provedeni resetovani win brany, nastaveni povolenych a blokovanych spojeni pocitace.
echo.
echo * Jde o okamzitou akci, ktera bude pripadne vyzadovat po restartovani pocitace 
echo *  .. nove povoleni/zakazani spojeni firewall brany.
echo * Niceho se neobavejte neni to zadny vetsi zasah do operacniho systemu.
echo. 
echo * Zvolte ciselnou volbu, kterou mate pravo prijmout i odmitnout pokracujete ENTER.
echo.
echo [1] ANO
echo [2] NE
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto firewall
if %op%==2 goto integ

:integ
cls
echo --------------------------------------------------------------------------------
echo Chcete provest kontrolu integrity OS?
echo --------------------------------------------------------------------------------
echo.
echo Vyhleda a opravi poskozene soubory operacniho systemu...doporucuji jednou za cas
echo.
echo * Casova narocnost je prumerne okolo 10 minut.
echo.
echo * Tento krok neni k cisteni OS nutne potrebny.
echo.
echo * Na druhou stranu "muze" chod operacniho systemu zrychlit.
echo. 
echo [1] ANO
echo [2] NE
echo off
set /p op=Zvolte (1/2):
if %op%==1 goto sfc
if %op%==2 goto konec
goto error

:sfc
cls
echo Vyvolavam nyni sken integrity...
echo.
echo off
sfc /scannow
echo.
echo off
pause
goto konec

:firewall
cls
echo Provadim resetovani spojeni firewall brany ...
echo.
echo off
netsh advfirewall reset
echo.
pause
goto integ

:konec
cls
title [Slava jsme na konci]
echo * Stisknutim klavesy provedeme restart pocitace.
echo.
pause
shutdown /r /f
exit /b
