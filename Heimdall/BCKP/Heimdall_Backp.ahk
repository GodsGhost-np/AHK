;Revision 16/11/2021
;Creator - Naveen Prasad Shankar
;I am Heimdall. The Gatekeeper, servant of all New. I am the guardian of this machine, serving, protecting & denying access to any unauthorised beings.
;#Persistent
SetTimer, CheckTime, 60000
;Return

CheckTime:
{
	
	if (A_Hour . A_Min=0740	)
	{
		
		
;ComObjCreate("SAPI.SpVoice").Speak("Good morning Naveen")
		MsgBox, 4, Heimdall , Good morning...Naveen `n ` `n`Would you like to check your mails
		ifMsgBox Yes
			{
			run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk
			sleep 1000
			return
			}
	}
;else if(A_Hour . A_Min=1100)
;{
;sleep 5000
;FileCopy \\ozd1147g\f\ARS_Folder\ARS Exchange folder\Tools\RAM\RAM.xlsx, C:\Users\uidn8279\Continental AG\L2IT Bangalore - L2IT Lab Booking, 1
;sleep 5000
;}
	else if (A_Hour . A_min=1230)
	{
		
;ComObjCreate("SAPI.SpVoice").Speak("Good Afternoon Time for Lunch ")
		MsgBox, 4,Heimdall, Good Afternoon...Time for Lunch ! `n  Are you going now ?
		ifMsgBox, No
		Loop, 10
				{
				sleep 60000
				MsgBox, ,Heimdall, Time for Lunch Naveen !!,30
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
		
		
		Msgbox, 262144, Heimdall,********** %greet% Welcome back Naveen **********, 2
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

!g::
{
search = "%Clipboard%"
	Clipboard =
	SendInput, ^c
	ClipWait, 5
	If ErrorLevel
	{
		MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard,3
		Return
	}
	Source = %Clipboard%
	if Source not contains www,http
		{
		Source := "https://www.google.co.in/search?q=" . Source
		}
	Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "%Source%" , max
	Source =
	Clipboard =
}

!f::
{
	send, nfunc_reli_0
	return
}
!b::
{
	InputBox, SpaceIp, Heimdall, `n How many lines, ,300,150, , , ,30
	Sleep 1000
	Loop, %SpaceIp%
	{
		Sleep 100
		sendinput, {space}
		sleep 100
		sendinput,{down}
	}
}

!o::
{
	FileRead, Contents, %A_WorkingDir%\VFS\VFS.txt
	sleep 1000

	IF Contents contains Earliest Available
	{
	 MsgBox % Contents
	}
	return
}

^!z::
{
	
	CurrentCB = %Clipboard%
	Clipboard =
	SendInput, ^c
	ClipWait, 5
	If ErrorLevel
	{
		MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard,5
		Return
	}
	Source = %Clipboard%
	StringLen, SourceLength, Source
	SourceLength := SourceLength * 5
	;ToolTip, Translating... please wait ?., % A_CaretX-SourceLength, % A_CaretY+50
	Target =
	Target := GoogleTranslate(Source)
	

	GoogleTranslate(Source)
	{

		StringReplace, Source, Source, %A_Space%, `%20, All
		Base := "translate.google.com/#"
		Path := Base . "de" . "/" . "en" . "/" . Source
		;Path := "https://www.google.co.in/search?q=" . Path
		Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "%Path%" , max
		Clipboard = 
	}
	return
}

PrintScreen::
{
	if WinExist("Snipping Tool")
		Winclose Snipping Tool
	clipboard=;
	SendInput, {CTRLDOWN}{PrintScreen}{CTRLUP}
	Run "C:\Windows\System32\mspaint.exe", , Max
	Sleep, 500
	 Send, {CTRLDOWN}v{CTRLUP}
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



;!w::
;{
;	FileCopy \\ozd1147w\f\ARS_Folder\ARS Exchange folder\Tools\RAM\RAM.xlsx, C:\Users\uidn8279\Continental AG\L2IT Bangalore - L2IT Lab Booking, 1
;		sleep 1000
;	msgbox Please go back to work
;	return
;}

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

!q::
{
send, Arabala, Nagesh <nagesh.arabala.3@aptiv.com>; P, Swetha <swetha.p@aptiv.com>; Pr, Annamalai <annamalai.pr@aptiv.com>; Va, Nivedha <nivedha.va@aptiv.com>; Rv, Nitesh Kumar <Nitesh.Kumar.Rv@aptiv.com>
return
}


!i::
{
Clipboard := ""
FileAppend `n`n%A_DD%/%A_MM%/%A_YYYY% :: %A_Hour%:%A_Min%, C:\Projects\BMW\Inconsistency\Inconsistency.txt
	loop, 30
	{
	
		Clipboard :=""
		send, {BS 2}
		send, {Shift down}{Tab 7}{Shift up}
		send, {Enter}
		sleep 1000
		send, {Shift down}{Tab}{Shift up}
		sleep 100
		send, ^a
		sleep 100
		send, ^c
		sleep 100
		send, ^c
		sleep 1000
		;MsgBox, ,Heimdall, %Clipboard%
		FileAppend `n%Clipboard%, C:\Projects\BMW\Inconsistency\Inconsistency.txt
		sleep 500
		send, {Shift down}{Tab}{Shift up}
		sleep 100
		send {NumpadDiv}{NumpadDiv}
		sleep 100
		send {Down}	
	}
	Run, C:\Program Files\Notepad++\notepad++.exe "C:\Projects\BMW\Inconsistency\Inconsistency.txt"
return	
}

;*****************************************************************  WORD ANALYZER    ******************************************************************************

!s::
{
	global Day:=%A_Min%
	
;ComObjCreate("SAPI.SpVoice").Speak("Hello Naveen Tell me what you need")
	InputBox, UserInput, Heimdall, `n Hello Naveen....Tell me what you need, ,300,150, , , ,30
	if Errorlevel
		sleep 1
		;MsgBox,,Heimdall, Okay whatever, 1
	else
	{
		StringSplit, Words, UserInput,%a_space%
		if(Words0=1)
		{
					if UserInput contains hi,hello,andi,hey,namaste,mornin,afternoon,eve,bonjour,hola,guten,hallo,ciao,ola
					{
						StringUpper, UserInput, UserInput, T
						MsgBox, ,Heimdall, %UserInput% Naveen......!
						return 
					}
					
					else if UserInput contains holiday
					run, C:\Users\zjjzrd\Documents\Trainings\Aptiv TCI Leave Calendar2022.pdf
					
					else if UserInput contains jira
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://jiraprod1.delphiauto.net:8080/projects/BAA/summary"
					
					else if UserInput contains who
					MsgBox, ,Heimdall, I am Heimdall. The Gatekeeper, servant of all New. I am the guardian of this machine, here to protect & serve. ,30

					else ifInString, UserInput, calc
					run, C:\Windows\System32\calc.exe
					
					else if UserInput contains BMW,contact
					run, C:\Tools\AHK\Heimdall\Screenshot\BMWContact.PNG

					else ifInString, UserInput, app
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://myapplications.microsoft.com/"

					else ifInString, UserInput, excel
					run, C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE

					else ifInString, UserInput, word
					run, C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE

					else ifInString, UserInput, ppt
					run, C:\Program Files\Microsoft Office\root\Office16\POWERPNT.EXE

					else ifInString, UserInput ,cim
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://cim.continental-corporation.com/servlet/hype/IMT?userAction=BrowseRoot&templateName="

					else ifInString, UserInput, mail
					run, C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE
					
					else ifInString, UserInput, workday
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://wd5.myworkday.com/aptiv/d/home.htmld"
					
					else ifInString, UserInput, aim
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://aim-aptiv.spigit.com/main/Page/AppHome"
				
					else ifInString, UserInput, jarvis
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://tci.aptiv.com/iTOSApps.aspx?app=jarvis"
					
					else ifInString, UserInput, learning
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://aptiv.csod.com/samldefault.aspx?ouid=1&returnUrl=https://aptiv.csod.com/phnx/driver.aspx?routename=Social/UniversalProfile/Transcript&TargetUser=43"
					
					else if UserInput contains payroll,payslip,fbp,salary
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "https://mypayroll.myndsolution.com/Login.aspx"
					
					else ifInString, UserInput, edit
					run, C:\Program Files\Notepad++\notepad++.exe "C:\Tools\AHK\Heimdall\Heimdall_Backp.ahk"
					
					else ifInString, UserInput, info.txt
					run, C:\Program Files\Notepad++\notepad++.exe "C:\Tools\AHK\Heimdall\info.txt"
					
					else ifInString, UserInput, compile
					run, C:\Tools\AHK\Heimdall\Heimdall_Compile.exe
					
					else ifInString, UserInput, note
					run, C:\Users\zjjzrd\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Notepad.lnk
					
					else ifInString, UserInput, autocorrect
					{	Process, Exist, AutoCorrect.exe
						If ErrorLevel = 0
						{
							run, %A_ScriptDir%\AutoCorrect\AutoCorrect.exe
							MsgBox, ,,Running,5
						}
						Else
						{
							Process, Close, AutoCorrect.exe
							MsgBox, ,,Closing,5
						}
						Return
					}
					
					else ifInString, UserInput, Mouse
					{	Process, Exist, MouseClick.exe
						If ErrorLevel = 0
						{
							run, %A_ScriptDir%\MouseClick.exe
							MsgBox, ,,Running,5
						}
						Else
						{
							Process, Close, MouseClick.exe
							MsgBox, ,,Closing,5
						}
						Return
					}
					
					else if UserInput contains planview,timesheet
					{readConfig()
					run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://pve.aptiv.com/planview/Track/Time/"
					
					}
					else ifInString, UserInput, vpn
					{
						run,  C:\Program Files\Palo Alto Networks\GlobalProtect\PanGPA.exe
						sleep, 2000
						Send, {Tab}
						Send, {Enter}
					}
					

					else ifInString, UserInput, date
					{
					StringRight, Week, A_YWeek, 2
					MsgBox, ,Heimdall, %A_DDDD%, %A_DD%/%A_MM%/%A_YYYY% ,  week : %Week% , Day of the year : %A_YDAY%,10
					}
					
					else ifInString, UserInput, hour
					{
					readConfig()
						run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "http://ozd1758w/#/"
						return
					}
					else ifInString, UserInput, door
					{
						
						run, C:\Users\zjjzrd\AppData\Local\Citrix\SelfService\Program Files\SelfService.exe
						
						Sleep 7000
						IfWinExist, Citrix Receiver
						{
							WinActivate   ;Automatically uses the window found above.
							WinMaximize Sleep, 500							
							Send, {Tab 6}Sleep, 500
							Send, {Enter}Sleep, 500
							WinMinimize
							return
						}
						Sleep 5000
						Send, {Tab}
						Send, {Enter}
						//WinWaitActive, , Windows sign-in - \\Remote, 3, , Requirements Manager			
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
					
;run C:\Users\%A_UserName%\Desktop\AHK\Heimdall\Reminder.exe %MyDate%%MyTime% "%ReminderText%"
					
					run %A_WorkingDir%\Reminder.exe %MyDate%%MyTime% "%ReminderText%"
					Gui Cancel
					return
						
;InputBox, RemInput, Heimdall, `n Tell me when and what, , 300,150,,  , 60
						
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
					
						InputBox, InfoInput, Heimdall, `n Tell me what should I remember for you,  , 300,150
							if ErrorLevel or InfoInput=""
									return
							else
							{
								if InfoInput contains =
									FileAppend, `n%InfoInput%, %A_WorkingDir%\info.txt
								sleep, 1000
								return
							}
					}
					
					else if(UserInput="todo")
					{
					
					InputBox, ToDoInput, Heimdall, `n Please list the To - DO's,  , 300,150,,  , 60
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
			{openscreenshot = 0
				Loop
				{
					StringCaseSense Locale
					FileReadLine, line, %A_WorkingDir%\info.txt, %A_Index%
					if ErrorLevel
							break
					FoundPos := RegExMatch(line, "=")
					variable := SubStr(line, 1, FoundPos-1)
					if (UserInput=variable)
					{
						op := SubStr(line, FoundPos+1, StrLen(line))
						
						
						if op contains http,www,C:
						{	
							link := op
							;msgbox %link%
							op :=
						}
						Finalop := Finalop . "`n" . op
						if(openscreenshot = 0)
						{
							Loop Files, %A_ScriptDir%\Screenshot\%UserInput%*  ; Recurse into subfolders.
								run, %A_LoopFileFullPath%, , Min
						openscreenshot = 1
						}
;break
					}
				}
				if Finalop=
					Finalop:="I did not get you"
				
				if(link=="")
					msgbox, , Heimdall, %Finalop%,30
				else
				{
					Gui, Destroy
					Gui, +Resize
					Gui, Font, cBlack
					Gui, Add, Text, , %Finalop%
					Gui, Font, cBlue
					Gui, Add, Text,gGotoSite, %link%
					Gui, Font, cBlack
					Gui, Show, , Heimdall
					Return
					
					GuiClose:
					Gui Cancel
					GotoSite:
					Run, %A_GuiControl%
					Finalop :=
					link :=
					return
				}
				Finalop :=
				link :=	
				
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
					MsgBox, , Heimdall, %Output%,30
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
						MsgBox, , Heimdall, hello,30
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
						
						MsgBox, , Heimdall, %Output% Naveen , 60
						Return
				}
				
				else if UserInput contains solve 
				{
					if UserInput contains rubik
					
					;MsgBox, , Heimdall, %UserInput%
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
						
					    StringReplace , UserInput, UserInput, %A_Space%, +, All
						UserInput := "https://www.google.co.in/search?q=" . UserInput
						Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe "%UserInput%" , max
						return
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