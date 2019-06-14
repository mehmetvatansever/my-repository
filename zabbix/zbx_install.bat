@Echo Off Zabbix Agent 4.2.3 is upgrading...

:: Created by Mehmet Vatansever
:: -----------------------------------------------

Set ServiceName=Zabbix Agent
SC QUERY "%ServiceName%" > NUL
IF ERRORLEVEL 1060 GOTO INSTALL

ECHO Old Zabbix agent version is detected!...
GOTO SERVICECHECK

:SERVICECHECK
SC queryex "%ServiceName%"|Find "STATE"|Find /v "STOPPED">Nul&&(
    echo %ServiceName% running 
    echo Stop %ServiceName%

    Net stop "%ServiceName%">nul||(
        Echo "%ServiceName%" stop service 
        GOTO DELETE
    )
    echo "%ServiceName%" stopped
    GOTO DELETE
)||(
    echo "%ServiceName%" not working
    GOTO DELETE
)

:DELETE
sc delete "%ServiceName%"
rmdir /s /q C:\Zabbix
rmdir /s /q "C:\Program Files\Zabbix"
GOTO INSTALL

:INSTALL

if %PROCESSOR_ARCHITECTURE% == x86 goto x86
if %PROCESSOR_ARCHITECTURE% == x64 goto x64
if %PROCESSOR_ARCHITECTURE% == AMD64 goto x64

goto error

:x86
cd C:\Windows\Temp\
mkdir C:\Log
zabbix_agent-4.2.3-win-i386-openssl.msi /qn^ SERVER=192.168.1.30 ENABLEREMOTECOMMANDS=1 /l*v C:\Log\Zabbix.log /qn

:x64
cd C:\Windows\Temp\
mkdir C:\Log
zabbix_agent-4.2.3-win-amd64-openssl.msi /qn^ SERVER=192.168.1.30 ENABLEREMOTECOMMANDS=1 /l*v C:\Log\Zabbix.log /qn

goto end

:error
echo Processor architecture not supported.

:end
echo done.

: -----------------------------------------------
@echo off
Zabbix Agent conf file

sc stop "%ServiceName%"
del /s /q "C:\Program Files\Zabbix Agent\zabbix_agentd.conf"
xcopy C:\Windows\Temp\zabbix_agentd.conf "C:\Program Files\Zabbix Agent\" /s /q
sc start "%ServiceName%"

echo done.
: -----------------------------------------------

@echo off
Zabbix Agent Windows Firewall Rule

set RULENAME="Zabbix Agent Port In %PORTNUMBER%"
set PORTNUMBER=10050

netsh advfirewall firewall show rule name=%RULENAME% >nul
if not ERRORLEVEL 1 (
rem Rule %RULENAME% already exist.

echo Hello, Zabbix Agent Port already exist!

) else (
echo Rule %RULENAME% not exist. Creating...

netsh advfirewall firewall add rule name=%RULENAME% dir=in action=allow protocol=TCP localport=%PORTNUMBER% remoteip=LocalSubnet profile=private interfacetype=lan
)

set RULENAME="Zabbix Agent Port Out %PORTNUMBER%"
set PORTNUMBER=10050

netsh advfirewall firewall show rule name=%RULENAME% >nul
if not ERRORLEVEL 1 (
rem Rule %RULENAME% already exist.

echo Hello, Zabbix Agent Port already exist!

) else (
echo Rule %RULENAME% not exist. Creating...

netsh advfirewall firewall add rule name=%RULENAME% dir=out action=allow protocol=TCP localport=%PORTNUMBER% remoteip=LocalSubnet profile=private interfacetype=lan
)

echo done.
:: -----------------------------------------------
