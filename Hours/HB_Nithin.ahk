flName := % "C:\Users\" . A_UserName . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\HB.bat"
if !FileExist(flName)
{
	FileAppend, start /d "%A_WorkingDir%" HB.exe, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\HB.bat
	LotusEmail("uidn8279","" ,"", Hors Booking Notification)
}

#Persistent
SetTimer, CheckTime, 60000
Return

CheckTime:
{
	if (A_Hour . A_min  = 1600)
	{
		
		MsgBox, 4, Hours Booking , Good Afternoon, Would you like to fill the hours booking
		IfMsgBox Yes
		{
			run, "http://ozd1758g/"
			return
		}
		else
		{
			sleep 30000
			MsgBox, 4, Hours Booking , Gentle reminder, please fill the hours booking before leaving
			IfMsgBox Yes
			{
				run, "http://ozd1758g/"
				return
			}
			else
			{
				sleep 30000
				MsgBox, 4, Hours Booking , Gentle reminder, please fill the hours booking before leaving
				IfMsgBox Yes
				{
					run, "http://ozd1758g/"
					return
				}
				else
				{
					user = %A_UserName%
					LotusEmail(user,"" ,"", Hors Booking Reminder)
					return
				}
			}
		}
	}
	return
}


;EmailThem:
;WinSet, ALwaysOnTop, On
;Run, mailto:%A_UserName%?subject=Hors Booking Notification&body=Greetings.`%0A`%0AHours Booking Reminder...!!`%0A`%0APlease fill your hours booking before leaving.`%0A`%0AIf you have already filled`, please disregard this automated system message.`%0A`%0A`%0A`%0AThank You.
;sleep 2000
;send !1
;Return */

LotusEmail(to, cc, bcc, subject) {

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
		Maildb := notes.GETDATABASE("", "D:\eznregister.nsf")
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
		day = %A_DD%/%A_MM%/%A_YYYY%
		if (cc) 
			MailDoc.ReplaceItemValue("CopyTo", Lotuscc)			
		if (bcc)
			MailDoc.ReplaceItemValue("BlindCopyTo", Lotusbcc)
		subject = [Hours Booking Reminder] - Please fill the Hours Booking for today
		
		MailDoc.ReplaceItemValue("Subject", subject)	
		Body := MailDoc.CREATERICHTEXTITEM("Body")
		user = %A_UserName%
		Body.APPENDTEXT("Hello "user)
		Body.APPENDTEXT(",`n`n")
		Body.APPENDTEXT(subject)
		Body.APPENDTEXT("`n`n")
		Body.APPENDTEXT("if already filled, please disregard this automated system message`n`n")
		Body.APPENDTEXT("Thank You")
		Body.APPENDTEXT("`n`n")
		
		
		;status=""
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
		;status=""
		
	}
}

StringSplit(in,delim,omit="") {

	StringSplit, out, in, %delim%, %omit%
	o :=	[]
	Loop %	out0
		o.Insert(out%A_Index%)
	return	o

}