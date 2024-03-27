global clmn:=2
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
			getString:=getSrNo(Accu)
		}
	}
		if Accu contains uid
		{
			if strlen(Accu)=8
			{
				if(getString!="")
				{
				msgbox, ,RAM, user %Accu% has taken %getString% store to excel, 1
				writeExcel(Accu,getString)
				LotusEmail(Accu,"uidn8279",Accu,"RAM - Notification",RAM - Notification details,Accu,getString)
				Accu:=""
				getString:=""
				}
				else
				{
					Accu:=""
					getString:=""
				}
			}
		}
Accu:=""
}
getSrNo(serial)
{
try
{
	FilePath :=  A_ScriptDir "\Lab Asset Details.xlsx"	; example path
	oWorkbook := ComObjGet(FilePath)		; access Workbook object

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
writeExcel(uid,hw)
{
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
		
		r = A%clmn%
		while(oWorkbook.Sheets(1).Range(r).Value != "")
		{
			clmn++
			break
		}
		r = A%clmn%
		oWorkbook.Sheets(1).Range(r).Value := hw
		r = B%clmn%
		oWorkbook.Sheets(1).Range(r).Value := uid
		r = C%clmn%
		sleep 1000
		day = %A_DD%/%A_MM%/%A_YYYY%__%A_Hour%:%A_Min%
		oWorkbook.Sheets(1).Range(r).Value := day
		oWorkbook.Save()
		XL.Quit()
		sleep 1000
		;LotusEmail(uid,"uid42645","uidr2668","RAM - Notification", User - %uid%  HW- %hw% taken at %day% )
		
		return
	}
	catch
	{
		oWorkbook.Save()
		XL.Quit()
	}
return
}



LotusEmail(to, cc, bcc, subject, ebody, user, hw) {

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
		
		if (cc) 
			MailDoc.ReplaceItemValue("CopyTo", Lotuscc)			
		if (bcc)
			MailDoc.ReplaceItemValue("BlindCopyTo", Lotusbcc)
		
		MailDoc.ReplaceItemValue("Subject", subject)	
		Body := MailDoc.CREATERICHTEXTITEM("Body")
		Body.APPENDTEXT(ebody)
		Body.APPENDTEXT(user)
		Body.APPENDTEXT("   - has taken -   ")
		Body.APPENDTEXT(hw)
		day = %A_DD%/%A_MM%/%A_YYYY%__%A_Hour%:%A_Min%
		Body.APPENDTEXT("  - at -   ")
		Body.APPENDTEXT(day)
		Body.APPENDTEXT(A_tab)
		Body.APPENDTEXT("Thank You")
		
		
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
		
		
	}
}

StringSplit(in,delim,omit="") {

	StringSplit, out, in, %delim%, %omit%
	o :=	[]
	Loop %	out0
		o.Insert(out%A_Index%)
	return	o

}
