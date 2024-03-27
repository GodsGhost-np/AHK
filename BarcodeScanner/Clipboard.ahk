
Loop, 96
  Hotkey, % "*~" . Chr(A_Index+26), BarCodeHandler, on
BarCodeHandler:
global Accu .= SubStr(A_ThisHotkey, 0)

   SetTimer, Chimichanga, -60
return

Chimichanga:
 {
  If Accu contains uidn
   {
   Msgbox, , RAM, Accu - %Accu%
   readAgain()
   Accu:=""

   return
	}
	else
	{
	Accu:=""
	return
	}
	return
	}
#singleInstance
readAgain()
{ 
  Loop, 96
	Hotkey, % "*~" . Chr(A_Index+26), BarCode, on
	BarCode:
	global get .= SubStr(A_ThisHotkey, 0)
	 SetTimer, Chimi, -60
	return
	Chimi:
	{
		If get contains pdhw
		{
			Msgbox, , RAM, get2 - %get%
			get :=""
			return
			SetTimer, Chimi, delete
			exit
		}
		else
		{
			get:=""
		}
		
		SetTimer, Chimi, delete
		return
   }
}

