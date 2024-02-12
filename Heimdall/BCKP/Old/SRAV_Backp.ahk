;SRAV is an embodiment of a Perfectionist 19 Feb 2019
;SRAV is an embodiment of a Perfectionist 2 Oct 2019
#Persistent
SetTimer, CheckTime, 60000
Return
CheckTime:
{
	try
	{
		FileCopy \\ozd1147w\f\ARS_Folder\ARS Exchange folder\Tools\RAM\RAM.xlsx, C:\Users\uidn8279\Continental AG\L2IT Bangalore - L2IT Lab Booking, 1
		sleep 1000
	
	return
	}
	if (A_Hour . A_Min=0740	)
	{
		
		
;ComObjCreate("SAPI.SpVoice").Speak("Good morning Naveen")
		MsgBox, 4, SRAV , Good morning...Naveen `n ` `n`Would you like to check your mails
		ifMsgBox Yes
			{
			run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk
			sleep 1000
			return
			}
	}
	else if(A_Hour . A_Min=1100)
	{
			sleep 5000
		FileCopy \\ozd1147g\f\ARS_Folder\ARS Exchange folder\Tools\RAM\RAM.xlsx, C:\Users\uidn8279\Continental AG\L2IT Bangalore - L2IT Lab Booking, 1
		sleep 5000
	}
	else if (A_Hour . A_min=1230)
	{
		
;ComObjCreate("SAPI.SpVoice").Speak("Good Afternoon Time for Lunch ")
		MsgBox, 4,SRAV, Good Afternoon...Time for Lunch ! `n  Are you going now ?
		ifMsgBox, No
		Loop, 10
				{
				sleep 60000
				MsgBox, ,SRAV, Time for Lunch Naveen !!,30
				}
		return
	}

	else if (A_Hour . A_Min =1600)
	{
		OnMessage(0x44, "WM_COMMNOTIFY") 
		MsgBox, 3, Hours Booking , Good Afternoon, Would you like to fill the hours booking
		IfMsgBox YES
		{
			run, "http://ozd1758g/"
			return
		}
		IfMsgBox, CANCEL
		{
			sleep 30000
			OnMessage(0x44, "WM_COMMNOTIFY") 
			MsgBox, 3, Hours Booking , Gentle reminder, please fill the hours booking before leaving
			IfMsgBox Yes
			{
				run, "http://ozd1758g/"
				return
			}
			else
			{
				sleep 30000
				OnMessage(0x44, "WM_COMMNOTIFY") 
				MsgBox, 3, Hours Booking , Gentle reminder, please fill the hours booking before leaving
				IfMsgBox Yes
				{
					run, "http://ozd1758g/"
					return
				}
				else
				{
					user = %A_UserName%
					
;LotusEmail(user,"" ,"", Hors Booking Reminder)
					return
				}
			}
		}
	}
	Return
}

readConfig()

WM_WTSSESSION_CHANGE(wParam, lParam, Msg, hWnd){
	static init:=(DllCall( "Wtsapi32.dll\WTSRegisterSessionNotification", UInt, A_ScriptHwnd, UInt, 1) && OnMessage(0x02B1, "WM_WTSSESSION_CHANGE"))
	
	;If (wParam=0x6 || wParam=0x7){ ;Logoff or lock
	;	Run, powercfg -change -monitor-timeout-ac 1,,Hide ;Set monitor standby timeout to 1 minute
	;	SendMessage,0x112,0xF170,2,,Program Manager ;Monitor Standby
	;}
	;Else
	If (wParam=0x5 || wParam=0x8){ ;Logon or unlock
		Run, powercfg -change -monitor-timeout-ac 20,,Hide		;Set monitor standby timeout to 20 minutes`
		if (A_Hour < 12)
				greet := "Good Morning......"  
			 if (A_Hour >= 12 and A_Hour <= 16 )
				greet := "Good Afternoon......"
			 if (A_Hour > 16 )
				greet := "Good Evening......"
		
		
		Msgbox, 262144, SRAV,********** %greet% Welcome back Naveen **********, 5
	}

		
			/*
			wParam::::::
			WTS_CONSOLE_CONNECT := 0x1 ; A session was connected to the console terminal.
			WTS_CONSOLE_DISCONNECT := 0x2 ; A session was disconnected from the console terminal.
			WTS_REMOTE_CONNECT := 0x3 ; A session was connected to the remote terminal.
			WTS_REMOTE_DISCONNECT := 0x4 ; A session was disconnected from the remote terminal.
			WTS_SESSION_LOGON := 0x5 ; A user has logged on to the session.
			WTS_SESSION_LOGOFF := 0x6 ; A user has logged off the session.
			WTS_SESSION_LOCK := 0x7 ; A session has been locked.
			WTS_SESSION_UNLOCK := 0x8 ; A session has been unlocked.
			WTS_SESSION_REMOTE_CONTROL := 0x9 ; A session has changed its remote controlled status. To determine the status, call GetSystemMetrics and check the SM_REMOTECONTROL metric.
			*/
}
~RButton::
~MButton::
~LButton::
If HideToolTip = 0
    Return
If ToolTipVisible = 1
{
    ToolTip
    ToolTipVisible = 0
    Return
}
Return
^!z::
{
	If ToolTipVisible = 1
	{
		ToolTip
		ToolTipVisible = 0
		Return
	}
	CurrentCB = %Clipboard%
	Clipboard =
	SendInput, ^c
	ClipWait, 5
	If ErrorLevel
	{
		MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard.
		Return
	}
	Source = %Clipboard%
	StringLen, SourceLength, Source
	SourceLength := SourceLength * 5
	ToolTip, Translating... please wait ?., % A_CaretX-SourceLength, % A_CaretY+50
	Target =
	Target := GoogleTranslate(Source)
	ToolTip, %Target%, % A_CaretX-SourceLength, % A_CaretY+50
	ToolTipVisible = 1
	If Paste2CB = 1
		Clipboard = %Target%
	Else
		Clipboard = %CurrentCB%
	Return

	GoogleTranslate(Source)
	{

		StringReplace, Source, Source, %A_Space%, `%20, All
		sleep 500
		Base := "translate.google.com/#"
		Path := Base . "auto" . "/" . "en" . "/" . Source
		IE := ComObjCreate("InternetExplorer.Application") ;~ Creation of hidden Internet Explorer instance to look up Google Translate and retrieve translation  		
		IE.Navigate(Path)
		While IE.readyState!=4 || IE.document.readyState!="complete" || IE.busy
				Sleep 50
		Result := IE.document.all.result_box.innertext
		
		IE.Quit
		Return Result
	}
	return
}

PrintScreen::
{
	Sendinput, {Ctrl down}{PrintScreen}{Ctrl up}
	Run "C:\Windows\System32\mspaint.exe", , Max
	Sleep, 500
	WinMaximize Paint
	Sleep, 1000
	 Send, {CTRLDOWN}v{CTRLUP}
	clipboard=;

	 return
}


 ;Press middle mouse button to move up a folder in Explorer
#IfWinActive, ahk_class CabinetWClass
~MButton::Send !{Up} 
#IfWinActive
return

!n::
{
	SendInput, {Raw}10/22/2019
	Send, {Ctrl down}a{Ctrl up}
	Send, {Raw}Naveen Shankar.
	return
}

!w::
{
	FileCopy \\ozd1147w\f\ARS_Folder\ARS Exchange folder\Tools\RAM\RAM.xlsx, C:\Users\uidn8279\Continental AG\L2IT Bangalore - L2IT Lab Booking, 1
		sleep 1000
	msgbox Please go back to work
	return
}
readConfig()
{
	Loop
	{
		FileReadLine, line, %A_WorkingDir%\Config.txt, %A_Index%
		if ErrorLevel
				break
		FoundPos := RegExMatch(line, "=")
		variable := SubStr(line, 1, FoundPos-1)
		if variable contains password
			global Password := SubStr(line, FoundPos+1, StrLen(line))
	}
	return
}

!g::
{
	Send, ^c
	Sleep 50
	Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://www.google.com/search?q=%clipboard%"
	sleep 100
	clipboard = %a_space%
	Return
}

;*****************************************************************  WORD ANALYZER    ******************************************************************************

!s::
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
					if UserInput contains hi,hello,andi,hey,namaste,mornin,afternoon,eve,bonjour,hola,guten,hallo,ciao,ola
					{
						StringUpper, UserInput, UserInput, T
						MsgBox, ,SRAV, %UserInput% Naveen......!
						return 
					}

					else ifInString, UserInput, calc
					run, C:\Windows\System32\calc.exe

					else ifInString, UserInput, ims
					run, C:\Program Files (x86)\Integrity\IntegrityClient11.2\bin\integrity.exe

					else ifInString, UserInput, excel
					run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2013\Excel 2013.lnk

					else ifInString, UserInput, word
					run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2013\Word 2013.lnk

					else ifInString, UserInput, ppt
					run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2013\PowerPoint 2013.lnk

					else ifInString, UserInput ,cim
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://cim.continental-corporation.com/servlet/hype/IMT?userAction=BrowseRoot&templateName="

					else ifInString, UserInput, mail
					run, C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE

					else ifInString, UserInput, vfbl
					MsgBox, ,SRAV, Stands for `n Vector Flash Boot loader `n Bootloader called VFBL – includes XCP boot loader, customer specific boot loader `n Download data blocks to different address areas `n Upload data block from different address areasAsychron CRC checks `n Read Infoblocks of different data blocks `n Start Application

					else ifInString, UserInput, bres
					MsgBox, ,SRAV, BRES: Boot manager - Ram initialisation and check Reset reason.`n Start different downloaded entities

					else ifInString, UserInput, bres
					MsgBox, ,SRAV, UFBL: Old Conti Bootloaders. Same functionalities as VFBL

					else ifInString, UserInput, BLUP
					MsgBox, ,SRAV, Boot loader Update: `n  Flashed with XCP or UDS to application address area`n Started automatically by Reset.`n Is removed by itself after successful UFBL/BRES update.`n A Blup can contain a VFBL, a BRES or both
					
					
					else ifInString, UserInput, connext
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "connext.conti.de/"

					else ifInString, UserInput, date
					{
					StringRight, Week, A_YWeek, 2
					MsgBox, ,SRAV, %A_DDDD%, %A_DD%/%A_MM%/%A_YYYY% ,  week : %Week% , Day of the year : %A_YDAY%
					}
					
					else ifInString, UserInput, hour
					{
					readConfig()
						run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://ozd1758w/#/"
						return
					}
					else ifInString, UserInput, door
					{
					readConfig()
						run, https://citrix-web.conti.de/Citrix/XenAppWeb/
						
						Sleep 10000
						Send, {Tab}
						Send, {Enter}
						WinWaitActive, , Login - DOORS - \\Remote, 3, , Requirements Manager
						Sleep 52000
						IfWinExist, Login - DOORS - \\Remote
						{
						WinActivate   ;Automatically uses the window found above.
						WinMaximize 
						Send, BCpfP{&}16
						Sleep, 500
						send, {Enter}
						return
						}
						IE.Quit
						
						
						
						
;WinWaitActive, , Login - \\Remote, 3, Requirements Manager
						
;Sleep, 1000
						
						
;Send, %Password%
						
;Sleep, 500
						
;send, {Enter}
						return
					}
					else if(UserInput="leave" or UserInput="attendance")
					{
					readConfig()
						run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://hrmsindia:82/Continental/Default.aspx"
						WinWaitActive, HRMS Esparsh - Google Chrome, ,3
						IfWinExist, HRMS Esparsh - Google Chrome
						{
						Sleep 1000
						send, {tab 4}
						Send, %A_UserName%
						sleep, 50
						send, {Tab}
						sleep, 50
						Send, %Password%
						send, {Enter}
						
						}
						return
					}
					else if(UserInput="reminder")
					{
					Gui, Destroy
					Gui, Add, Text,, Reminder description:
					Gui, Add, Edit, w350 h50 vReminderText
					Gui, Add, Text,, Date
					Gui, Add, DateTime, vMyDate, LongDate
					Gui, Add, Text,, Time
					Gui, Add, DateTime, vMyTime, Time 
					Gui, Add, Button, vB, Submit
					Gui, Show
					return
					
					ButtonSubmit:
					Gui, Submit, nohide
					FormatTime, MyDate, %MyDate%, yyyyMMdd
					FormatTime, MyTime, %MyTime%, HHmm
					
;msgbox %MyDate% -  %MyTime%  Reimnder text %ReminderText%
					
;run C:\Users\%A_UserName%\Desktop\AHK\SRAV\Reminder.exe %MyDate%%MyTime% "%ReminderText%"
					
					run %A_WorkingDir%\Reminder.exe %MyDate%%MyTime% "%ReminderText%"
					Gui Cancel
					return
						
;InputBox, RemInput, SRAV, `n Tell me when and what, , 300,150, , , 60
						
;if ErrorLevel or RemInput=""
						
;	return
						
;else
						
;{
						
;	time := SubStr(RemInput,-3)
						
;	RemInput := SubStr(RemInput, 1, StrLen(RemInput)-4)
						
  ; run %A_WorkingDir%\Reminder.exe %time% "%RemInput%"
						
;}
					}
					
					else if(UserInput="info")
					{
					
					InputBox, InfoInput, SRAV, `n Tell me what should I remember for you,  , 300,150, , , 60
						if ErrorLevel or InfoInput=""
								return
						else
						{
						if InfoInput contains =
						FileAppend `n%InfoInput%, %A_WorkingDir%\info.txt
						sleep, 2000
						return
						}
					}
					
					else if(UserInput="todo")
					{
					
					InputBox, ToDoInput, SRAV, `n Please list the To - DO's,  , 300,150, , , 60
						if ErrorLevel or ToDoInput=""
								return
						else
						{
							Run C:\Windows\Explorer.exe %windir%\system32\StikyNot.exe
							sleep 1000
							
							SendRaw, [%A_hour%:%A_min%] - %ToDoInput% `n
							sleep, 1000
							Send {Ctrl down}n{Ctrl up}
							return
						}
					}

			else
			{
				Loop
				{
					FileReadLine, line, %A_WorkingDir%\info.txt, %A_Index%
					if ErrorLevel
							break
					FoundPos := RegExMatch(line, "=")
					variable := SubStr(line, 1, FoundPos-1)
					if (UserInput=variable)
					{
						op := op . " , " . SubStr(line, FoundPos+1, StrLen(line))
						
;break
					}
				}
				if op=
					op:="I did not get you"
					
				MsgBox, 262144, SRAV, %UserInput% :: %op%
				op=
			}
			return
		}

		
;*****************************************************************  Sentence ANALYZER  ******************************************************************************

		else if(Words0>1)
		{
			firstWord := % GetWordPos(UserInput, 1)
			
;firstWord := SubStr(UserInput, 1 , %a_space%)
			Punct := SubStr(UserInput,0,1)

				If(Punct=".")
				{
					Output := "That's nice to know."
					MsgBox, , SRAV, %Output%
				}
				else ifInString, Punct, ?
				{
					UserInput := SubStr(UserInput, 1, StrLen(RemInput)-1)
					StringReplace , UserInput, UserInput, %A_Space%, +, All
						UserInput := "https://www.google.co.in/search?q=" . UserInput
					Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "%UserInput%" , max
					
					return
				}
				else if firstWord contains how,when,what,where,why,who,which,is
					{
					IfWinActive, New Tab - Google Chrome
						{
						WinActivate  ;Automatically uses the window found above.
						MsgBox, , SRAV, hello
						}
						StringReplace , UserInput, UserInput, %A_Space%, +, All
						UserInput := "https://www.google.co.in/search?q=" . UserInput
						
						Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "%UserInput%" , max
						
						return
					}
					
				else if firstWord contains good,gud,gute
				{
					if (A_Hour < 12)
						output := "Good Morning......"  
					if (A_Hour >= 12 and A_Hour <= 18 )
						output := "Good Afternoon......"
					if (A_Hour > 18 )
						output := "Good Evening......"
						
						MsgBox, , SRAV, %Output% Naveen , 60
						Return
				}
				
				else if UserInput contains solve 
				{
					if UserInput contains rubik
					
;MsgBox, , SRAV, %UserInput%
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://www.google.com/logos/2014/rubiks/iframe/index.html"
				Sleep 8000
				Send, feelsdd{Shift down}s{shift up}ds{Shift down}d{shift up}{Shift down}s{shift up}{Shift down}b{shift up}
				Send, db{Shift down}d{shift up}rr{Shift down}r{shift up}dr{Shift down}l{shift up}dl
				Send, dr{Shift down}d{shift up}{Shift down}r{shift up}d{Shift down}f{shift up}df
				Send, d{Shift down}f{shift up}dfdr{Shift down}d{shift up}{Shift down}r{shift up}
				Send, df{Shift down}d{shift up}{Shift down}f{shift up}{Shift down}d{shift up}{Shift down}l{shift up}dl
				Send, {Shift down}d{shift up}{Shift down}b{shift up}dbdl{Shift down}d{shift up}{Shift down}l{shift up}
				Send, {Shift down}d{shift up}{Shift down}d{shift up}{Shift down}r{shift up}drdb{Shift down}d{shift up}{Shift down}b{shift up}
				Send, {Shift down}d{shift up}l{Shift down}d{shift up}{Shift down}l{shift up}{Shift down}d{shift up}{Shift down}b{shift up}db
				Send, bdl{Shift down}d{shift up}{Shift down}l{shift up}{Shift down}b{shift up}rdb
				Send, {Shift down}d{shift up}{Shift down}b{shift up}{Shift down}r{shift up}{Shift down}l{shift up}{Shift down}d{shift up}{Shift down}b{shift up}dbl
				Send, l{Shift down}r{shift up}d{Shift down}l{shift up}{Shift down}d{shift up}rdl{Shift down}d{shift up}{Shift down}l{shift up}
				Send, l{Shift down}r{shift up}{Shift down}d{shift up}rd{Shift down}l{shift up}{Shift down}d{shift up}{Shift down}r{shift up}dr
				Send, f{Shift down}d{shift up}{Shift down}d{shift up}{Shift down}f{shift up}{Shift down}d{shift up}f{Shift down}d{shift up}{Shift down}f{shift up}
				Send, {Shift down}b{shift up}ddbd{Shift down}b{shift up}dbyy
				Send, f{Shift down}d{shift up}{Shift down}d{shift up}{Shift down}f{shift up}{Shift down}d{shift up}f{Shift down}d{shift up}{Shift down}f{shift up}
				Send, {Shift down}b{shift up}ddbd{Shift down}b{shift up}db
				return

						
				}
					else 
					{
						Output := "Okay, I will think about it"
						MsgBox, , SRAV, %Output% 
					}

		return
		}
		GetWordPos(word, num)
			{
				StringSplit, wordArray, word, % A_Space
				return wordArray%num%
			}
	}
}