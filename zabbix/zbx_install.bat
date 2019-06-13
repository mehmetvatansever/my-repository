ECHO 
Zabbix Agent 4.2.3 is installing...

if %PROCESSOR_ARCHITECTURE% == x86 goto x86
if %PROCESSOR_ARCHITECTURE% == x64 goto x64
if %PROCESSOR_ARCHITECTURE% == AMD64 goto x64

goto error

:x86
msiexec /l*v C:\Windows\Temp\Zabbix_log.txt /i C:\Windows\Temp\zabbix_agent-4.2.3-win-amd64-openssl.msi /qn^ SERVER=192.168.1.30 ENABLEREMOTECOMMANDS=1

:x64
msiexec /l*v C:\Windows\Temp\Zabbix_log.txt /i C:\Windows\Temp\zabbix_agent-4.2.3-win-i386-openssl.msi /qn^ SERVER=192.168.1.30 ENABLEREMOTECOMMANDS=1

goto end

:error
echo Processor architecture not supported.

:end
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
