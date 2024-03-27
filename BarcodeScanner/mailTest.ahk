StringSplit(in,delim,omit="") {

	StringSplit, out, in, %delim%, %omit%
	o :=	[]
	Loop %	out0
		o.Insert(out%A_Index%)
	return	o

}

;LotusEmail(to, cc, bcc, subject, ebody, attach, test) {

	try {

		if(test)
		{
			to := "uidn8279@continental-corporation.com,uidn8279@continental-corporation.com"
			cc := ""
			bcc := "uidn8279@continental-corporation.com"
			subject:="testing!!!!"
		}
			
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
;}