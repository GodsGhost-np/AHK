
Loop
{
sleep 30000
FormatTime, OutputVar , ,yyyyMMddHHmm

;msgbox %OutputVar%  -  %1%
	if OutputVar = %1%
	{
		break
	}
}
#SingleInstance, force
;ComObjCreate("SAPI.SpVoice").Speak("%2%")
SoundBeep, 750, 500  ; Soundbeep, freq, duration
		OnMessage(0x44, "WM_COMMNOTIFY")
		MsgBox, 4, Reminder , %2%
		ifMsgBox, YES
			{
				sleep 60000
				SoundBeep, 750, 500 
				MsgBox, 262144, Snooze, %2%
				
			}
ExitApp 

WM_COMMNOTIFY(wParam) { 
    if (wParam = 1027) { ; AHK_DIALOG 
        Process, Exist 
        DetectHiddenWindows, On 
        if WinExist("Reminder ahk_class #32770 ahk_pid " . ErrorLevel) { 
          ControlSetText, Button1, &Snooze 
          ControlSetText, Button2, &Close
        } 
    } 
}


