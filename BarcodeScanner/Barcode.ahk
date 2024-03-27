#singleinstance global i := 1
Loop, 96
  Hotkey, % "*~" . Chr(A_Index+26), BarCodeHandler, on
BarCodeHandler:
global Accu .= SubStr(A_ThisHotkey, 0)

   SetTimer, Chimichanga, -60
return

Chimichanga:
  ;msgbox, ,SRAV, %Accu%
   readConfig(Accu)
   global i = 1
 ; If Accu contains uidn
  ; {
   ;writeExcel(op)
   ;Msgbox, , RAM, %op%
   ;}
   
   Accu:=""
   op:=""
   
   
return

readConfig(match)
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
						global op := SubStr(line, FoundPos+1, StrLen(line))
						;Msgbox, , RAM, op= %op%
						writeExcel(op,i)
						i++ 
					}
			}
		}
	return
}


writeExcel(data,row)
{

	try XL := ComObjActive(Excel.Application)
	catch 
	{
		XL := ComObjCreate("Excel.Application")
		XL.visible := 0
	}

fn := "C:\Users\uidn8279\Desktop\RAM1.xlsx"

oWorkbook := XL.Workbooks.Open(fn)
r = A%i%

oWorkbook.Sheets(1).Range(r).Value := data
r = B%i%
sleep 1000
day = %A_DD%/%A_MM%/%A_YYYY%__%A_Hour%:%A_Min%

oWorkbook.Sheets(1).Range(r).Value := day
sleep 500
i++
sleep 500
oWorkbook.Save()
sleep 500

XL.Quit()
sleep 1000

return
}

