global clmn:=3
global hwCode:=""
global FilePath := "\\OZD1147g\f\ARS_Folder\ARS Exchange folder\Tools\RAM\RAM.xlsx"
Loop, 96
  Hotkey, % "*~" . Chr(A_Index+26), BarCodeHandler, on
BarCodeHandler:
global Accu .= SubStr(A_ThisHotkey, 0)

   SetTimer, Chimichanga, -60
return
Chimichanga:
{
	if(strlen(Accu)>3)
	{
		IfNotInString, Accu, uid
		{
			hwCode=%Accu%
		
			getString:=getSrNo(Accu)
		}
	}
		if Accu contains uid
		{
			if strlen(Accu)=8
			{
				if(getString!="")
				{
					;msgbox, ,RAM, user %Accu% has taken %getString% store to excel, 1
					writeExcel(Accu,getString,hwCode)
					Accu:=""
					getString:=""	
				}	
				else
				{
						ComObjCreate("SAPI.SpVoice").Speak("hardware not found")		
						Soundbeep, 700, 1000
						msgbox, 262144 ,RAM, HW : %hwCode% is not present in Lab Assets, 2
					Accu:=""
					getString:=""
				}
			}	
			else
				{
						ComObjCreate("SAPI.SpVoice").Speak("Retry")	
						Soundbeep, 700, 1000
					Accu:=""
					getString:=""
				}
		}
		
		
Accu:=""
}

global clmn:=3
#Persistent
SetTimer, CheckTime, 60000
Return

CheckTime:
{
if (A_Hour . A_Min=2358)
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
		;fn := A_ScriptDir "\RAM.xlsx"
		oWorkbook := XL.Workbooks.Open(FilePath)
	oWorkbook.Sheets(1).Rows(clmn).EntireRow.Insert		
	clmn++
		loop
		{
		r=F%clmn%
		findBlank=A%clmn%
			if(oWorkbook.Sheets(1).Range(r).Text="")
			{
				oWorkbook.Sheets(1).Range(r).Interior.ColorIndex := 3
				oWorkbook.Sheets(1).Range(r).Offset(0,1).Interior.ColorIndex := 3
				oWorkbook.Sheets(1).Range(r).Offset(0,-3).Interior.ColorIndex := 3
				clmn++
			}
			else
			clmn++
			if(oWorkbook.Sheets(1).Range(findBlank).Text="")
			{
			break
			return
			}
		}
		oWorkbook.Save()
					XL.Quit()
					sleep 500
	}catch
	{
		oWorkbook.Save()
		XL.Quit()
	}
}
}

!r::
Gui, Destroy
Gui, Add, Text,, Device name:
Gui, Add, Edit, w200 vName
Gui, Add, Text,, Serial number:
Gui, Add, Edit, w200 vSYno
Gui, Add, Text,, User uid number:
Gui, Add, Edit, w200 vUid
Gui, Add, Button,xm vA, Borrow
Gui, Add, Button,xm vB, Return
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

GuiClose:  ; User closed the window.
Gui, cancel



getSrNo(serial)
{
	try
	{
		AssetPath :=  A_ScriptDir "\Lab Asset Details.xlsx"	; example path
		oWorkbook := ComObjGet(AssetPath)		; access Workbook object

		; Get a Range object that represents the first cell in column N where the information is found.
		; Then, using offset(Row, Col), get the text from the cell in column M directly left of the found cell.
		global FoundM := oWorkbook.Sheets(1).Range("D:D").Find(serial).Offset(0,-3).Text
		;if (FoundM=="")
		;	FoundM := "notfound"
	}
	catch
	{
		FoundM:=""
	}	
return FoundM
}

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
		;fn := A_ScriptDir "\RAM.xlsx"
		oWorkbook := XL.Workbooks.Open(FilePath)
		if (uid!="") && (hw!="") && (hwId!="")
		{
		
			if(oWorkbook.Sheets(1).Range("B:B").Find(hwId).Offset(0,0).Text)
			{
				findId:=oWorkbook.Sheets(1).Range("B:B").Find(hwId).Offset(0,1).Text
				if(uid==findId)
				{
					if(oWorkbook.Sheets(1).Range("B:B").Find(hwId).Offset(0,4).value=="")
					{
					oWorkbook.Sheets(1).Range("B:B").Find(hwId).Offset(0,4).value:=day
					oWorkbook.Sheets(1).Range("B:B").Find(hwId).Offset(0,5).value:=time
					oWorkbook.Save()
					;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "returned")
					XL.Quit()
					
					ComObjCreate("SAPI.SpVoice").Speak("Thank you")
						Soundbeep, 700, 500
						Soundbeep, 700, 500	
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
					
					ComObjCreate("SAPI.SpVoice").Speak("Successful")
						Soundbeep, 700, 500
						Soundbeep, 700, 500	
					;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "taken")
					return
					}
				}
				else
				{
				if(oWorkbook.Sheets(1).Range("B:B").Find(hwId).Offset(0,4).value!="")
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
					
					
					ComObjCreate("SAPI.SpVoice").Speak("Successful")
						Soundbeep, 700, 500
						Soundbeep, 700, 500	
						;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "taken")
					return
				}
					else
					{
					
						ComObjCreate("SAPI.SpVoice").Speak("Hardware not returned")
						Soundbeep, 700, 1000
						msgbox,,RAM, Hardware not returned by the last user, 2
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
					
					
				;LotusEmail(uid,"uidn8279",uid,"[RAM - Notification] ",uid,hw, "taken")
				ComObjCreate("SAPI.SpVoice").Speak("Successful")
						Soundbeep, 700, 500
						Soundbeep, 700, 500	
				return
			}
		}
		else
		{
			ComObjCreate("SAPI.SpVoice").Speak("Retry")
						Soundbeep, 700, 1000
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



LotusEmail(to, cc, bcc, subject, user, hw, status) {

	try {

		;if(test)
		;{
		;	to := "uidn8279@continental-corporation.com,uidn8279@continental-corporation.com"
		;	cc := ""
		;	bcc := "uidn8279@continental-corporation.com"
		;	subject:="testing!!!!"
		;}
			
		notes := ComObjCreate("Lotus.NotesSession")
		notes.initialize()
;		notes.Initialize("<password>") 
		Maildb := notes.GETDATABASE("", A_ScriptDir "\eznregister.nsf")
		MailDoc := Maildb.CREATEDOCUMENT
		MailDoc.ReplaceItemValue("Form", "Memo")
		
		to := StringSplit(to, "`," , A_Space)
		cc := StringSplit(cc, "`," , A_Space)
		bcc := StringSplit(bcc, "`," , A_Space)

		count1 := to._MaxIndex()
		Lotusto := ComObjArray(VT_VARIANT:=12, count1)

		for index, element in to
		{
			Lotusto[index-1] := element
		}

		count1 := cc._MaxIndex()
		Lotuscc := ComObjArray(VT_VARIANT:=12, count1)
		for index, element in cc 
		{
			Lotuscc[index-1] := element

		}

		count1 := bcc._MaxIndex()
		Lotusbcc := ComObjArray(VT_VARIANT:=12, count1)

		for index, element in bcc 
		{
			Lotusbcc[index-1] := element
		}
		MailDoc.ReplaceItemValue("SendTo", Lotusto)
		day = %A_DD%/%A_MM%/%A_YYYY%__%A_Hour%:%A_Min%
		if (cc) 
			MailDoc.ReplaceItemValue("CopyTo", Lotuscc)			
		if (bcc)
			MailDoc.ReplaceItemValue("BlindCopyTo", Lotusbcc)
		subject = %subject% : %user% - has %status% - %hw% - at - %day%
		MailDoc.ReplaceItemValue("Subject", subject)	
		Body := MailDoc.CREATERICHTEXTITEM("Body")
		ebody = %ebody%%user%."hastaken"
		Body.APPENDTEXT(subject)
		
		
		Body.APPENDTEXT(A_tab)
		Body.APPENDTEXT("Thank You")
		
		status=""
		MailDoc.SAVEMESSAGEONSEND := True
		FormatTime, CurrentDateTime, , MM/dd/yyyy HH:mm:ss
; This is to have a copy of the email in the "sent items" folder, doesn't work yet
;		MsgBox The current time and date (date first) is %CurrentDateTime%.
;		MailDoc.ReplaceItemValue("PostedDate", CurrentDateTime)
;		MailDoc.PostedDate(CurrentDateTime)
		MailDoc.SEND(False)

	} catch e {
		MsgBox, 16,, % "Error!`n`nwhat: " e.what "`nfile: " e.file "`nline: " e.line "`nmessage: " e.message "`nextra: " e.extra


		body := ""
		MailDoc := ""
		Maildb := ""
		notes := ""
		status=""
		
	}
}

StringSplit(in,delim,omit="") {

	StringSplit, out, in, %delim%, %omit%
	o :=	[]
	Loop %	out0
		o.Insert(out%A_Index%)
	return	o

}




