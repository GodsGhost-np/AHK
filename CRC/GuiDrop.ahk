
; Example: Simple text editor with menu bar.; 

; Create the sub-menus for the menu bar:
Menu, FileMenu, Add, &New, FileNew
Menu, FileMenu, Add, &Open, FileOpen
Menu, FileMenu, Add, &Save, FileSave
Menu, FileMenu, Add, Save &As, FileSaveAs
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &About, HelpAbout

; Create the menu bar by attaching the sub-menus to it:
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

; Attach the menu bar to the window:
Gui, Menu, MyMenuBar
Gui, Add, Button, vA, Calculate
; Create the main Edit control and display the window:
Gui, +Resize  ; Make the window resizable.
gui, font, cBlack s12, Consolas ;<--
Gui, Add, Edit, vMainEdit WantTab W600 R40 Uppercase

 
Gui, Show,, Untitled
CurrentFileName =  ; Indicate that there is no current file.
return

FileNew:
GuiControl,, MainEdit  ; Clear the Edit control.
return

FileOpen:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, 3,, Open File, Text Documents (*.mot)
if SelectedFileName =  ; No file selected.
    return
Gosub FileRead
return

FileRead:  ; Caller has set the variable SelectedFileName for us.
FileRead, MainEdit, %SelectedFileName%  ; Read the file's contents into the variable.
if ErrorLevel
{
    MsgBox Could not open "%SelectedFileName%".
    return
}
GuiControl,, MainEdit, %MainEdit%  ; Put the text into the control.
CurrentFileName = %SelectedFileName%
Gui, Show,, %CurrentFileName%   ; Show file name in title bar.
return

FileSave:
if CurrentFileName =   ; No filename selected yet, so do Save-As instead.
    Goto FileSaveAs
Gosub SaveCurrentFile
return

FileSaveAs:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, S16,, Save File, Text Documents (*.txt)
if SelectedFileName =  ; No file selected.
    return
CurrentFileName = %SelectedFileName%
Gosub SaveCurrentFile
return

SaveCurrentFile:  ; Caller has ensured that CurrentFileName is not blank.
IfExist %CurrentFileName%
{
    FileDelete %CurrentFileName%
    if ErrorLevel
    {
        MsgBox The attempt to overwrite "%CurrentFileName%" failed.
        return
    }
}
GuiControlGet, MainEdit  ; Retrieve the contents of the Edit control.
FileAppend, %MainEdit%, %CurrentFileName%  ; Save the contents to the file.
; Upon success, Show file name in title bar (in case we were called by FileSaveAs):
Gui, Show,, %CurrentFileName%
return

HelpAbout:
Gui, About:+owner1  ; Make the main window (Gui #1) the owner of the "about box".
Gui +Disabled  ; Disable main window.
Gui, About:Add, Text,, CRC calculator Calculates the Overall and line checksum automatically
Gui, About:Add, Button, Default, OK
Gui, About:Show
return

AboutButtonOK:  ; This section is used by the "about box" above.
AboutGuiClose:
AboutGuiEscape:
Gui, 1:-Disabled  ; Re-enable the main window (must be done prior to the next step).
Gui Destroy  ; Destroy the about box.
return

GuiDropFiles:  ; Support drag & drop.
Loop, Parse, A_GuiEvent, `n
{
    SelectedFileName = %A_LoopField%  ; Get the first file only (in case there's more than one).
    break
}
Gosub FileRead
return

GuiSize:
if ErrorLevel = 1  ; The window has been minimized.  No action needed.
    return
; Otherwise, the window has been resized or maximized. Resize the Edit control to match.
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, MainEdit, W%NewWidth% H%NewHeight%
return

ButtonCalculate:
;Gosub SaveCurrentFile
Lastline := StrTail(2,MainEdit)
LastLine := substr(LastLine, 2 , 5)

LastLine := RegExMatch("S30E01143A800A01000000000000FF18", "^S(\d)(\w\w)(.*?)(\w\w)$", SubPat) 
srecInfo := { 3 : "8", 2 : "6", 1 : "4" } ;

AddrType := % srecInfo[SubPat1]
Addr := Substr(SubPat3,1, AddrType)

HexData := "0x"SubPat2
msgbox %HexData%



RemLength := SubPat2 - (1 + AddrType/2)
msgbox %RemLength%
;run, D:\PPAR_CRC\PPAR_CRC.bat

return

;Funtion to get the first line from the mot file
getFirstLine(gg1)
{
	return SubStr(gg1,1,InStr(gg1,"`r")-1)
}

;Function to get the last line
StrTail(k,str) 
   {
   StringReplace, str, str, `n, `n, UseErrorLevel ; get number of lines
   Lines:=ErrorLevel  ; add one to get last line (thanks Skan!)
   Loop, parse, str, `n, `r
      {
      If ((Lines - k) < A_Index)
	  {  
		L := A_LoopField "`n"
		break
	  }
      }
   Return L
   }



FileExit:     ; User chose "Exit" from the File menu.
GuiClose:  ; User closed the window.
ExitApp