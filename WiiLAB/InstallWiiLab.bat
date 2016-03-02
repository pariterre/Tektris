echo off
cls


copy /b/y NUL %WINDIR%\06CF2EB6-94E6-4a60-91D8-AB945AE8CF38 >NUL 2>&1
if errorlevel 1 (
	echo Please run this script as administrator
	pause
	goto:eof
)
del %WINDIR%\06CF2EB6-94E6-4a60-91D8-AB945AE8CF38 >NUL 2>&1



echo **** Creating Directories ****
mkdir C:\\"Program Files"\WiiLAB\WiiLAB
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\GraphingFunctions
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\BouncingBallFunctions
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@AccelState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@ButtonState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@CoGState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@IRState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@LEDState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@NunchukButtonState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@NunchukJoystickState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@SensorState
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@Wiimote
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\EG111-H
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\DemoPrograms
mkdir C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\DemoPrograms\DemoPresentation
mkdir C:\\"Program Files"\WiiLAB\WiiLABTest


echo **** Copying nessecary files to your computer. ****
copy %~dp0\WiiLAB\* C:\\"Program Files"\WiiLAB\WiiLAB /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\GraphingFunctions\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\GraphingFunctions /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\BouncingBallFunctions\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\BouncingBallFunctions /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@AccelState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@AccelState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@ButtonState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@ButtonState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@CoGState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@CoGState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@IRState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@IRState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@LEDState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@LEDState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@NunchukButtonState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@NunchukButtonState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@NunchukJoystickState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@NunchukJoystickState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@SensorState\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@SensorState /v /y
copy %~dp0\WiiLAB_Matlab\WiimoteFunctions\@Wiimote\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\@Wiimote /v /y
copy %~dp0\WiiLAB_Matlab\EG111-H\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\EG111-H /v /y
copy %~dp0\WiiLAB_Matlab\DemoPrograms\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\DemoPrograms /v /y
copy %~dp0\WiiLAB_Matlab\DemoPrograms\DemoPresentation\* C:\\"Program Files"\WiiLAB\WiiLAB_Matlab\DemoPrograms\DemoPresentation /v /y


echo **** Unregister WiiLab.dll ****
C:\windows\Microsoft.NET\Framework\v4.0.30319\regasm C:\\"Program Files"\WiiLAB\WiiLAB\WiiLAB.dll /unregister
echo **** Register WiiLab.dll   ****
C:\windows\Microsoft.NET\Framework\v4.0.30319\regasm C:\\"Program Files"\WiiLAB\WiiLAB\WiiLAB.dll /tlb:WiiLAB.tlb /codebase



echo ****WiiLAB Successfully installed! Press enter to view the ReadMe File.****


pause

echo off
cls

C:\\"Program Files"\WiiLAB\WiiLAB\readme.txt

exit




