@echo off
setlocal EnableDelayedExpansion

if "%~1"=="/silent" goto main

whoami /user | find /i "S-1-5-18" > nul 2>&1 || (
	call RunAsTI.cmd "%~f0" "%*"
	exit /b
)

:main
:: Disable Bluetooth drivers and services
call setSvc.cmd BluetoothUserService 4
call setSvc.cmd BTAGService 4
call setSvc.cmd BthA2dp 4
call setSvc.cmd BthAvctpSvc 4
call setSvc.cmd BthEnum 4
call setSvc.cmd BthHFEnum 4
call setSvc.cmd BthLEEnum 4
call setSvc.cmd BthMini 4
call setSvc.cmd BTHMODEM 4
call setSvc.cmd BthPan 4
call setSvc.cmd BTHPORT 4
call setSvc.cmd bthserv 4
call setSvc.cmd BTHUSB 4
call setSvc.cmd HidBth 4
call setSvc.cmd Microsoft_Bluetooth_AvrcpTransport 4
call setSvc.cmd RFCOMM 4

:: Disable Bluetooth devices
call toggleDev.cmd "*Bluetooth*"

for /f "tokens=3 delims==\" %%a in ('wmic computersystem get username /value ^| find "="') do set "loggedinUsername=%%a"
attrib +h "C:\Users\%loggedinUsername%\AppData\Roaming\Microsoft\Windows\SendTo\Bluetooth File Transfer.LNK"

if "%~1"=="/silent" exit

echo Finished, please reboot your device for changes to apply.
pause
exit /b
