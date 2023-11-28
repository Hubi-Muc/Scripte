@echo off

REM https://wiki.securepoint.de/AV/Installation/AutomatisierteInstallation
REM Installationsscript für SophosClient

tasklist /nh /fi "imagename eq Sophos UI.exe" | find /i "Sophos UI.exe" >nul && (
exit
) || (
start /wait msiexec /l* "[Pfad\zur\Datei]\setuplog_%COMPUTERNAME%.txt" /i "SophosSetup.exe --products=antivirus,intercept --language=1031 --quiet"
)
exit


REM SophosSetup.exe --products=antivirus,intercept --language=1031 --quiet
