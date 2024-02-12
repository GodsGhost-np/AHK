Process, Close, Heimdall.exe
sleep 1000
RunWait "C:\Tools\AHK\AutoHotkey_1.1.33.09\Compiler\Ahk2Exe.exe" /in "C:\Tools\AHK\Heimdall\Heimdall_Backp.ahk" /out "C:\Tools\AHK\Heimdall\Heimdall.exe" /bin "C:\Tools\AHK\AutoHotkey_1.1.33.09\Compiler\ANSI 32-bit.bin" /compress 0
sleep 1000
Run C:\Tools\AHK\Heimdall\Heimdall.exe