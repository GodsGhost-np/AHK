;Start up notepad, for this example it will become the child window
Run, Notepad.exe,,,pid
WinWait, ahk_pid %pid%   ;wait for a notepad window to exist...
child := WinExist("ahk_pid " pid)  ;Get the hwnd, you can also just use a window title here or ahk_class

;Create a gui, and store its hwnd in the variable parent
Gui, +hwndParent +Resize
Gui, Show, w500 h500

;Set notepad to be the child of our gui
DllCall("SetParent", "ptr", Child, "ptr", Parent)

;Move notepad into view
WinMove, ahk_id %child%,, 1, 1, 480, 480
return

GuiClose:
  ExitApp
return