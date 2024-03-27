#SingleInstance, force
msgbox %A_ScriptName%
OnMessage(0x44, "WM_COMMNOTIFY") 
MsgBox, 4, Add or Delete, Choose a button:
IfMsgBox, YES 
    MsgBox, You chose Add. 
else 
    MsgBox, You chose Delete. 
ExitApp 

WM_COMMNOTIFY(wParam) { 
    if (wParam = 1027) { ; AHK_DIALOG 
        Process, Exist 
        DetectHiddenWindows, On 
        if WinExist("Add or Delete ahk_class #32770 ahk_pid " . ErrorLevel) { 
          ControlSetText, Button1, &Add 
          ControlSetText, Button2, &Delete
        } 
    } 
}