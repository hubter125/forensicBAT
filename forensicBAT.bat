@ECHO ON

SET "Dir=%computername%"
mkdir "%Dir%" 2>nul
type nul > %Dir%\test.txt
SET "outputFile=%Dir%\test.txt"

(ECHO. ) > "%outputFile%"

ECHO Live dump of %computername%: >> "%outputFile%"
ECHO --------------------------------------------------------------- >> "%outputFile%"
ECHO Computer Name: %computername% >> "%outputFile%"
ECHO Date: %date% >> "%outputFile%"
ECHO Time: %time% >> "%outputFile%"
ECHO --------------------------------------------------------------- >> "%outputFile%"

for /f "tokens=*" %%a in ('systeminfo ^| find "System Boot Time"') do set "bootTime=%%a"

for /f "tokens=3,4,5,6 delims= " %%b in ("%bootTime%") do set "bootTime=%%b %%c %%d %%e"

echo System Boot Time: %bootTime% >> "%outputFile%"
ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO NIC configuration settings (IP, Gateway,DNS etc) >> "%outputFile%"

ECHO --------------------------------------------------------------- >> "%outputFile%"

ipconfig /all >> "%outputFile%"
ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO ROUTE TABLE

ECHO --------------------------------------------------------------- >> "%outputFile%"

netstat -r >> "%outputFile%"
ECHO --------------------------------------------------------------- >> "%outputFile%"

start /B netstat -a >> "%outputFile%"
timeout /t 5 /nobreak >nul 2>&1

powershell Stop-Process -Name "netstat" -Force

ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO LOGGED ON USERS: >> "%outputFile%"

ECHO --------------------------------------------------------------- >> "%outputFile%"

PsLoggedon64.exe >> "%outputFile%"

ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO ALL USER ACCOUNTS: >> "%outputFile%"

net user >> %outputFile%

ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO RUNNING SERVICES >> %outputFile%

ECHO --------------------------------------------------------------- >> "%outputFile%"

net start >> %outputFile%

ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO RUNNING PROCESSES >> %outputFile%

ECHO --------------------------------------------------------------- >> "%outputFile%"

tasklist >> %outputFile%

ECHO --------------------------------------------------------------- >> "%outputFile%"

ECHO SHARED FILES AND DRIVES >> %outputFile%

ECHO --------------------------------------------------------------- >> "%outputFile%"

psfile >> %outputFile%





