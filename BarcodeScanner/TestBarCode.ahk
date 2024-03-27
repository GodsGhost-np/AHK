global clmn = 2
Loop, 96
  Hotkey, % "*~" . Chr(A_Index+26), BarCodeHandler, on
BarCodeHandler:
global Accu .= SubStr(A_ThisHotkey, 0)

   SetTimer, Chimichanga, -60
return

Chimichanga:
{

  If Accu contains uid
  {
	  if strlen(Accu)=8
	   {
		if(readConfigUID(Accu))
		  { 
		  pdhw:=""
		 ; uid := readConfigUID(Accu)
		 uid := Accu
		   ;Msgbox, , RAM, Accu - %uid%
		   Accu:=""
		   }
		  else
		  {
		 msgbox, ,RAM, User : %Accu% - not present in config.txt file
		  return
		  }
		}
		
  }
	if Accu contains pdhw
	{
		if(uid !="")
		{ 	
			if(readConfigPDHW(Accu))
			{
				;msgbox, , RAM, %Accu%
				pdhw := Accu
				
				;msgbox, ,RAM,writing data to excel, 1
				writeExcel(uid,hw_CfgNumber,email_id)
				uid:=""
			}
			else
			{
				msgbox, ,RAM, HW : %Accu% - not present in config.txt file
				uid:=""
				pdhw:=""
				return
			}
		}
	}
	Accu:=""
	
	return
}
return

readConfigUID(match)
{
	Loop
		{
			FileReadLine, line, %A_WorkingDir%\config.txt, %A_Index%
			if ErrorLevel
					break
			FoundPos := RegExMatch(line, "=")
			
			variable := SubStr(line, 1, FoundPos-1)
			if match contains uidn,pdhw
			{
				if (match=variable)
					{
						global op := SubStr(line, FoundPos+1, strlen(line))
						
						;Msgbox, , RAM, Found - %op%
						;msgbox %email_id%
						
					}
			}
		}
	return op
}

readConfigPDHW(match)
{
	Loop
		{
			FileReadLine, line, %A_WorkingDir%\config.txt, %A_Index%
			if ErrorLevel
					break
			FoundPos := RegExMatch(line, "=")
			
			variable := SubStr(line, 1, FoundPos-1)
			if match contains pdhw
			{
				if (match=variable)
					{
						global hw_CfgNumber := SubStr(line, FoundPos+1, strlen(line))
						
						;Msgbox, , RAM, Found - %hw_CfgNumber%
						;msgbox %email_id%
						
					}
			}
		}
	return hw_CfgNumber
}



writeExcel(uid,hw_CfgNumber,email_id)
{

	try XL := ComObjActive(Excel.Application)
	catch 
	{
		XL := ComObjCreate("Excel.Application")
		XL.visible := 0
	}
try
{
fn := "C:\Users\uidn8279\Desktop\RAM1.xlsx"

oWorkbook := XL.Workbooks.Open(fn)


r = A%clmn%
while(oWorkbook.Sheets(1).Range(r).Value != "")
{
clmn++

break
}
r = A%clmn%
oWorkbook.Sheets(1).Range(r).Value := pdhw

r = B%clmn%
oWorkbook.Sheets(1).Range(r).Value := uid

r = C%clmn%
sleep 1000
day = %A_DD%/%A_MM%/%A_YYYY%__%A_Hour%:%A_Min%

oWorkbook.Sheets(1).Range(r).Value := day

oWorkbook.Save()
XL.Quit()
sleep 1000
mailto(uid,hw_CfgNumber,email_id,day)
return
}
catch
{
	oWorkbook.Save()
XL.Quit()
}
return
}

mailto(name,hw_CfgNumber,mailId,day)
{
run, mailto:%name%?subject=RAM - Object Notification&body=User : %name%. `%0A`%0A HW: %hw_CfgNumber% taken at %day%.`%0A`%0A Thank you`%0A`%0A This is an Auto-Generated Email. , , hide
;run, C:\Program Files (x86)\Lotus\Notes85\notes.exe mailto:%mailId%?subject="RAM - Object Notification" ?cc="dipanjali.saha@continental-corporation.com"?body="User : %uid% HW: %pdhw% taken at %day%" , ,Hide?cc=dipanjali.saha@continental-corporation.com
sleep 2000
send, {alt down}1{alt up}
}
