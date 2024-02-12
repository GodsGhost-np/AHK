!q::
{
global Day:=%A_Min%
;ComObjCreate("SAPI.SpVoice").Speak("Hello Naveen Tell me")
InputBox, UserInput, SRAV, `n Hello Naveen....Tell me,  , 300,150, , , 60
if Errorlevel
	MsgBox,,SRAV, Okay whatever, 1
	else
	{
StringSplit, Words, UserInput,%a_space%
if(Words0=1)
{
	Loop
		{
			FileReadLine, line, %A_WorkingDir%\Dict.txt, %A_Index%
			if ErrorLevel
					break
			;FoundPos := RegExMatch(line, %A_Space%)
			;variable := SubStr(line, 1, FoundPos-1)
			if (UserInput=line)
			{
			MsgBox found := %line%
				op := line				
				break
				return
			}
			
		}
		if op=
			MsgBox Word not found
			
		else
		 MsgBox %line% : Word found
	
}
}
}