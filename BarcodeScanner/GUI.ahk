!r::

Gui, Destroy
Gui, Add, Text,, Device name:
Gui, Add, Edit, vName
Gui, Add, Text,, Serial number:
Gui, Add, Edit, vSYno
Gui, Add, Text,, User uid number:
Gui, Add, Edit, vUid
Gui, Add, Button, vA, Borrow
Gui, Add, Button, vB, Return
Gui, Show

return

ButtonBorrow:
Gui, Submit
;msgbox %Name% - %SYno% - %Uid%
writeExcel(Uid,Name,SYno)
Gui, cancel
return

ButtonReturn:
Gui, Submit
;msgbox %Name% - %SYno% - %Uid%
writeExcel(Uid,Name,SYno)
Gui, cancel
return

GuiSize:
if ErrorLevel = 1  ; The window has been minimized.  No action needed.
    return
; Otherwise, the window has been resized or maximized. Resize the Edit control to match.
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, MainEdit, W%NewWidth% H%NewHeight%
return

Esc::
GuiClose:  ; User closed the window.
ExitApp

writeExcel(uid,hw,hwId)
{
day = %A_DD%/%A_MM%/%A_YYYY%
			time = %A_Hour%:%A_Min%
		try XL := ComObjActive(Excel.Application)
		catch 
		{
			XL := ComObjCreate("Excel.Application")
			XL.visible := 0
		}
	try
	{
		fn := A_ScriptDir "\RAM.xlsx"
		oWorkbook := XL.Workbooks.Open(fn)
		if(oWorkbook.Sheets(1).Range("A:A").Find(hw).Offset(0,0).Text)
		{
			findId:=oWorkbook.Sheets(1).Range("A:A").Find(hw).Offset(0,2).Text
			if(uid==findId)
			{
				if(oWorkbook.Sheets(1).Range("A:A").Find(hw).Offset(0,5).value=="")
				{
				oWorkbook.Sheets(1).Range("A:A").Find(hw).Offset(0,5).value:=day
				oWorkbook.Sheets(1).Range("A:A").Find(hw).Offset(0,6).value:=time
				oWorkbook.Save()
				;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "returned")
				ComObjCreate("SAPI.SpVoice").Speak("Thank you")
					Soundbeep, 350, 500
					Soundbeep, 350, 500	
				}
				else
				{
				oWorkbook.Sheets(1).Rows(clmn).EntireRow.Insert
				r = A%clmn%
				oWorkbook.Sheets(1).Range(r).Value := hw
				r = B%clmn%
				oWorkbook.Sheets(1).Range(r).Value := hwId
				r = C%clmn%
				oWorkbook.Sheets(1).Range(r).Value := uid
				r = D%clmn%
				oWorkbook.Sheets(1).Range(r).Value := day
				r = E%clmn%
				oWorkbook.Sheets(1).Range(r).Value := time
				oWorkbook.Save()
				XL.Quit()
				sleep 500
				ComObjCreate("SAPI.SpVoice").Speak("Successful")
					Soundbeep, 350, 500
					Soundbeep, 350, 500	
				;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "taken")
				return
				}
			}
			else
			{
			if(oWorkbook.Sheets(1).Range("A:A").Find(hw).Offset(0,5).value!="")
			{
				oWorkbook.Sheets(1).Rows(clmn).EntireRow.Insert
				r = A%clmn%
				oWorkbook.Sheets(1).Range(r).Value := hw
				r = B%clmn%
				oWorkbook.Sheets(1).Range(r).Value := hwId
				r = C%clmn%
				oWorkbook.Sheets(1).Range(r).Value := uid
				r = D%clmn%
				oWorkbook.Sheets(1).Range(r).Value := day
				r = E%clmn%
				oWorkbook.Sheets(1).Range(r).Value := time
				oWorkbook.Save()
				XL.Quit()
				sleep 500
				
				ComObjCreate("SAPI.SpVoice").Speak("Successful")
					Soundbeep, 350, 500
					Soundbeep, 350, 500	
					;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "taken")
				return
			}
				else
				{
				msgbox,,RAM, Hardware not returned by the last user, 2
					ComObjCreate("SAPI.SpVoice").Speak("Hardware not returned")
					Soundbeep, 350, 1000
				}
			}
		}
		else
		{
			oWorkbook.Sheets(1).Rows(clmn).EntireRow.Insert
				r = A%clmn%
				oWorkbook.Sheets(1).Range(r).Value := hw
				r = B%clmn%
				oWorkbook.Sheets(1).Range(r).Value := hwId
				r = C%clmn%
				oWorkbook.Sheets(1).Range(r).Value := uid
				r = D%clmn%
				oWorkbook.Sheets(1).Range(r).Value := day
				r = E%clmn%
				oWorkbook.Sheets(1).Range(r).Value := time
				oWorkbook.Save()
				XL.Quit()
				sleep 500
				
			;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "taken")
			ComObjCreate("SAPI.SpVoice").Speak("Successful")
					Soundbeep, 350, 500
					Soundbeep, 350, 500	
			return
		}
		
		XL.Quit()
		
	}
	catch
	{
		oWorkbook.Save()
		XL.Quit()
	}
return
}