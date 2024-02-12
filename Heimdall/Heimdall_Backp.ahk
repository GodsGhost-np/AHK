;Revision 16/11/2021
;Creator - Naveen Prasad Shankar first implementation 2017
;I am Heimdall. The Gatekeeper, servant of all New. I am the guardian of this machine, serving, protecting & denying access to any unauthorised beings.
;#Persistent
;SetTimer, CheckTime, 60000
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

^!g::
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
	Run, C:\Program Files\Google\Chrome\Application\chrome.exe "%Source%" , max
	Source =
	Clipboard =
}

!f::
{
	;send,
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
	send {Enter}
	return
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



^!y::
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
		Run, C:\Program Files\Google\Chrome\Application\chrome.exe "%Path%" , max
		Clipboard =
	}
	return
}

;PrintScreen::
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

;!n::
{

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
SourceLength := SourceLength * 5
ToolTip, Translating... please wait, % A_CaretX-SourceLength, % A_CaretY+50
Target =
Target := DeeplTranslate(Source, "en", "de")
ToolTip, %Target%, % A_CaretX-SourceLength, % A_CaretY+50
Clipboard = %Target%
DeeplTranslate(Source,LangIn,LangOut)
{
    StringReplace, Source, Source, %A_Space%, `%20, All  ;you don't need this, but you can keep it in
    Base := "https://www.deepl.com/en/translator#"
    Path := Base . LangIn . "en" . LangOut . "de" . Source
    IE := ComObjCreate("InternetExplorer.Application") ;~ Creation of hidden Internet Explorer instance to look up Google Translate and retrieve translation
    IE.Navigate(Path)
    While IE.readyState!=4 || IE.document.readyState!="complete" || IE.busy
        Sleep 50
	While (IE.document.getElementsByTagName("textarea")[1].value = "")  ;Since the conversion takes a second we want to wait till the value is filled otherwise the return will always be nothing
		Sleep 50
    Result := IE.document.getElementsByTagName("textarea")[1].value
    IE.Quit
    Return Result
}
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

^!l::
{
Send,
(
SW Version: Y108(fe24972)
MEST Version: X-ME-C-Y107_from_X108_RC06_140922&selection=partition_img.bin
Dataset : au583_Datasets_Y107_Aurix.zip | au583_Datasets_Y107_EyeQ.zip
Sample: H13
ECU Number: WLO-TIE09.12.2100010023
Test Platform: Faslhing station
Defect ID: N/A
CANoe Version: CANoe 15 SP4
Test log Path: W:\66_Audi_MFK5_Share\SysTestRecord\L2H0090_KP03.25.10_MFK5_Y108\L2H0090_KP03.25.10_MFK5_Y108_fe24972\SmokeTest\BSW_SmokeTest

Comment : Test result is as expected
)
return
}

^!b::
{
Send, BCpfP&16  ;encoded with base64, use plugin command to disable
return
}

^!e::
{
send, naveenprasad.shankar@magna.com
return
}
^!p::
{
Send, LlRbvrfZyWn4IYDk
return
}

;;;;;;;;;;;;PTC item search with ctrl alt w
^!w::
{
	PTCitem = %Clipboard%
	Clipboard =
	SendInput, ^c
	ClipWait, 3
	If ErrorLevel
	{
		MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard,5
		Return
	}
	PTCitem = %Clipboard%
;msgbox %PTCitem%
if PTCitem is digit
	if(StrLen(PTCitem)>4 && StrLen(PTCitem)<12)
		run, cmd.exe /K im viewissue -g %PTCitem%
	

return
}


^!r::
{
	PTCitem = %Clipboard%
	Clipboard =
	SendInput, ^c
	ClipWait, 3
	If ErrorLevel
	{
		MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard,5
		Return
	}
	PTCitem = %Clipboard%
;msgbox %PTCitem%

	;if(StrLen(PTCitem)>4 && StrLen(PTCitem)<12)
		run, cmd.exe %PTCitem%
	

return
}

^!m::
{
	Send, echo 2000 > /sys/kernel/debug/tracing/buffer_size_kb
	Send, {Enter}
	Send, echo > /sys/kernel/debug/tracing/trace
	Send, {Enter}
	Send, echo "gic" > /sys/kernel/debug/tracing/trace_clock
	Send, {Enter}
	Send, echo "sched_switch" > /sys/kernel/debug/tracing/set_event
	Send, {Enter}
	Send, echo "irq" >> /sys/kernel/debug/tracing/set_event
	Send, {Enter}
	Send, echo 1 > /sys/kernel/debug/tracing/events/eyeq_acc/enable
	Send, {Enter}
	Send, echo "1" > /sys/kernel/debug/tracing/tracing_on
	Send, {Enter}

	Send, trace-cmd restore -c -o header.dat
	Send, {Enter}
	Send, ftpput 192.168.1.1 header.dat
	Send, {Enter}
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
	Run, C:\Program Files (x86)\Notepad++\notepad++.exe "C:\Projects\BMW\Inconsistency\Inconsistency.txt"
return
}

;Diag read out from file
!d::
{
	fileread, FileInfo, %A_WorkingDir%\Task\DIDs.txt
	MouseGetPos, MouseX, MouseY
	Gui, Destroy
	Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  
	Gui, Color, WindowColor884488, ControlColorFFFF99
	Gui, Font, s12  
	Gui, Add, Text, vFileInfo cred, %FileInfo%   
	WinSet, TransColor, EEAA99 200
	Gui, Show, x%MouseX% y%MouseY%
	return

}

;Google tranlatin for 5secs for language
!r::
{
SourceLength = 0

	search1 = "%Clipboard%"
	Clipboard =
	SendInput, ^c
	ClipWait, 2
	If ErrorLevel
	{
		MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard,3
		Return
	}
	Source1 = %Clipboard%
	
	Length := StrLen(Source1)
	
	if(Length>11 && Length>11)
	{	ToolTip, input length issue
		SetTimer, RemoveToolTip, -3000
		return
		}
	else
	{
		StringReplace, Source1, Source1, %A_SPACE%,, All
		First := SubStr(Source1,1, 2)
		Second := SubStr(Source1,3, 4)
		
		ToolTip, Timed ToolTip`nThis will be displayed for 5 seconds.
		SetTimer, RemoveToolTip, -9000
		return
	}
	Length = 0
	

	RemoveToolTip:
	ToolTip
	return
	
	
	Clipboard :=
	
return
}

HexToString(String) 
   { 
   local Length, CharStr, RetString 
    
   ;Return '0' if the string was blank 
   If !String 
      Return 0 

   Length := StrLen(String)//2 

   ;Parse the String 
   Loop, %Length% 
      { 
      ;Retrieve Hex 
      StringMid, CharStr, String, [color=red]A_Index*2 - 1[/color], 2 
      
      ;[color=red]CharStr = 0x%CharStr%[/color]

      ;Build the return string 
      RetString .= Chr(CharStr) 
      
      } 
    
   ;Return the string to the caller 
   Return RetString 
   }


;*****************************************************************  WORD ANALYZER    ******************************************************************************

!s::
{
	global Day:=%A_Min%

;ComObjCreate("SAPI.SpVoice").Speak("Hello Naveen Tell me what you need")
	InputBox, UserInput, Heimdall, `n Hello Naveen....Tell me what you need, ,300,150, , , ,
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

					else if UserInput contains who
					MsgBox, ,Heimdall, I am Heimdall. The Gatekeeper, servant of all New. I am the guardian of this machine, here to protect & serve. ,30

					else ifInString, UserInput, calc
					run, C:\Windows\System32\calc.exe

					else ifInString, UserInput, excel
					run, C:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE

					else ifInString, UserInput, word
					run, C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE

					else ifInString, UserInput, ppt
					run, C:\Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE

					else ifInString, UserInput, win
					run, C:\iSYSTEM\winIDEA9\winIDEA.exe


					else if UserInput contains payroll,payslip,fbp,salary
					run, C:\Program Files\Google\Chrome\Application\chrome.exe ""

					else ifInString, UserInput, edit
					run, C:\Program Files (x86)\Notepad++\notepad++.exe "C:\Tools\AHK\Heimdall\Heimdall_Backp.ahk"

					else ifInString, UserInput, info.txt
					run, C:\Program Files (x86)\Notepad++\notepad++.exe "C:\Tools\AHK\Heimdall\info.txt"

					else ifInString, UserInput, compile
					run, C:\Tools\AHK\Heimdall\Heimdall_Compile.exe

					else ifInString, UserInput, note
					run, Notepad.exe
					
					else ifInString, UserInput, ntsh
					run, C:\Users\zjjzrd\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Notepad.lnk

					else ifInString, UserInput, sap
					run, C:\Program Files\Google\Chrome\Application\chrome.exe "https://sap-mhp.magna.global:8300/nwbc/?sap-nwbc-node=0000000062&sap-nwbc-context=03HM333035D633D53336743434B7B48C77F50DF0F18F74758D8F8888770D0E8E0F77718C373230323235802833303230360001635F8F0020D31CC436343031CB28292928B6D2D72F4E2CD0CDCD28D0CB4D4CCF4BD44BCFC94F4ACCB1B200EAD1CF2B4F4AD6B707C927E764A6E695D80235AB81B8398979E9A589E9A9B62EAE00&sap-client=070&sap-language=DE&sap-nwbc-history_item=&sap-accessibility=X&sap-theme=sap_corbu"
					
					else ifInString, UserInput, clockin
					{
					run, C:\Program Files\Google\Chrome\Application\chrome.exe "https://sap-fge.magna.global:8443/fiorisso?sap-client=010&sap-language=EN#ZKWPXSSCiCoSem-display"
					Sleep 3000
					send {TAB}
					Sleep 100
					send {TAB}
					Sleep 100
					send {TAB}
					Sleep 100
					send {Enter}			
					
					}
					
					else ifInString, UserInput, clockout
					{
					run, C:\Program Files\Google\Chrome\Application\chrome.exe "https://sap-fge.magna.global:8443/fiorisso?sap-client=010&sap-language=EN#ZKWPXSSCiCoSem-display"
					Sleep 3000
					send {TAB}
					Sleep 100
					send {TAB}
					Sleep 100
					send {TAB}
					Sleep 100
					send {TAB}
					Sleep 100
					send {Enter}			
					
					}
					
					else ifInString, UserInput, workday
					run, C:\Program Files\Google\Chrome\Application\chrome.exe https://wd3.myworkday.com/magna/d/home.htmld

					else ifInString, UserInput, tictac
					run, %A_ScriptDir%\TicTac\TicTac.exe
					
					else ifInString, UserInput, DID
					run, C:\Program Files (x86)\Notepad++\notepad++.exe %A_WorkingDir%\Task\DIDs.txt
					
					else if UserInput=46
					run, mstsc /v:meedtxtenva46 /f
					
					else if UserInput=45
					run, mstsc /v:meedtxtenva45 /f 
					
					else if UserInput=25
					run, mstsc /v:meedtxtenva25 /f
					
					else if UserInput=16
					run, mstsc /v:meedtxtenva16 /f
					
					else if UserInput=15
					run, mstsc /v:meedtxtenva15 /f
					
					else if UserInput=07
					run, mstsc /v:memdtxtenv07 /f
					
					else if UserInput=48
					run, mstsc /v:meedtxtenva48 /f
					
					else if UserInput=38
					run, mstsc /v:meedtxtenva38 /f
					
					else if UserInput=17
					run, mstsc /v:meedtxtenva17 /f
					
					else if UserInput=41
					run, mstsc /v:meedtxtenv41 /f
					
					else if UserInput=34
					run, mstsc /v:meedtxtenv34 /f
					
					else if UserInput=024
					run, mstsc /v:meewb0024 /f
					
					else if UserInput=025
					run, mstsc /v:meewb0025 /f
					
					else if UserInput is digit
						{
						if(StrLen(UserInput)>4 && StrLen(UserInput)<12)
					run, cmd.exe /K im viewissue -g %UserInput%
					}
					
					else ifInString, UserInput, cw48
					run, C:\Program Files\Google\Chrome\Application\chrome.exe "https://magnaelectronics.screenconnect.com/Host#Access/ELC_SystemTest_MFK5/48/b347f4e0-cbed-4fa1-96c3-b8a806d87bf3"
					
					else ifInString, UserInput, admin
					run, C:\Program Files\Google\Chrome\Application\chrome.exe "https://itserviceportal.magna.global/wm/app-SelfServicePortal/notSet/preview-object/SPSArticleTypeService/27138c41-e11c-e611-2a94-005056956d7a/0/"
					
					else ifInString, UserInput, concur
					run, C:\Program Files\Google\Chrome\Application\chrome.exe "https://www.concursolutions.com/home.asp"

					else ifInString, UserInput, net					
					{
						;Run, *RunAs %ComSpec% /c netsh interface set interface name="magna.global secure WiFi access WPA2Ent" admin=disabled,, Hide
						;Sleep 60000
						Run, *RunAs %ComSpec% /c netsh interface set interface name="magna.global secure WiFi access WPA2Ent" admin=enabled,, Hide
						return
					}
					else ifInString, UserInput, sleep
					DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
					else ifInString, UserInput, ping
					{
					run cmd.exe /K ping fd53:7cb8:383:2::4f -t
					;Send ping fd53:7cb8:383:2::4f fd53:7cb8:383:2::fc10 -t
					return
					}
					
					else ifInString, UserInput, pingmfk5
					{
					run cmd.exe /K ping fd53:7cb8:383:2::4f -S fd53:7cb8:383:2::fc10 -t
					;Send ping fd53:7cb8:383:2::4f fd53:7cb8:383:2::fc10 -t
					return
					}
					
					else ifInString, UserInput, pingmfk120
					{
					run cmd.exe /K ping fd53:7cb8:383:2::4f -S fd53:7cb8:383:2::10 -t
					;Send ping fd53:7cb8:383:2::4f fd53:7cb8:383:2::fc10 -t
					return
					}
					
					else ifInString, UserInput, flash
					{
					run cmd /K cd C:\Users\naveshan\Desktop & OdxPdxFlasher.exe --adapterIP fd53:7cb8:383:2::10
					return
					}
					
					
					
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
						run, C:\Program Files\Google\Chrome\Application\chrome.exe "http://ozd1758w/#/"
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
						run, C:\Program Files\Google\Chrome\Application\chrome.exe "http://hrmsindia:82/Continental/Default.aspx"
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



					run %A_WorkingDir%\Reminder.exe %MyDate%%MyTime% "%ReminderText%"
					Gui Cancel
					return



					}

					else if(UserInput="save")
					{
						InputBox, InfoInput, Heimdall, `n Tell me what command should I save for you,  , 300,150
					if ErrorLevel or InfoInput=""
									return
							else
							{
							split1 := SubStr(InfoInput, 1, RegExMatch(InfoInput,";")-1)
							split2 := SubStr(InfoInput, RegExMatch(InfoInput,";")+1, StrLen(InfoInput))
							msgbox, %split1% %split2% %A_ScriptFullPath%
								FileAppend,
								(
								%split1%::
								{Send, %split2%
								return
								}

								), %A_ScriptFullPath%
							}
					return
					}

					else if(UserInput="info")
					{

						InputBox, InfoInput, Heimdall, `n Tell me what should I remember for you,  , 300,150
							if ErrorLevel or InfoInput=""
									return
							else
							{
								if InfoInput contains =
									if(StrLen(InfoInput)>150)
									{
									    FoundPos1 := RegExMatch(InfoInput, "=")
										split1 := SubStr(InfoInput, 1, FoundPos1-1)
										;msgbox, , split1, %split1%,30
										FileAppend, `n%split1%, %A_WorkingDir%\info.txt
										
										FoundPos2 := SubStr(InfoInput, FoundPos1, StrLen(InfoInput))
										;msgbox, , FoundPos2, %FoundPos2%,30
										;split2 := SubStr(InfoInput, 1, FoundPos2) . SubStr(InfoInput, StrLen(InfoInput)/2 + (StrLen(SubStr(InfoInput, 1, FoundPos2))-1), StrLen(InfoInput))
										FileAppend, %FoundPos2%, %A_WorkingDir%\info.txt
										
										;msgbox, , split2, %split2%,30
									}
									else
										FileAppend, `n%InfoInput%, %A_WorkingDir%\info.txt
								sleep, 1000
								return
							}
					}

	else if(UserInput="task")
					{

						InputBox, TaskInput, Heimdall, `n Tell me what should I remember in task for you,  , 300,150
							if ErrorLevel or TaskInput=""
									return
							else
							{
							today = %A_DD%/%A_MM%/%A_YYYY%
							msgbox %today%
							if(today != %A_DD%/%A_MM%/%A_YYYY%)
								FileAppend, 'n**********%A_DD%/%A_MM%/%A_YYYY%**********, %A_WorkingDir%\Task\Tasks.txt
								
								FileAppend, `n%TaskInput%, %A_WorkingDir%\Task\Tasks.txt
										
										msgbox, , TaskInput, %TaskInput%,30
									
								sleep, 500
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

							 Loop %link%, 1
								link := A_LoopFileLongPath

							;msgbox %link%
							op :=
						}
						Finalop := Finalop . "`n" . op
						;msgbox, , Heimdall, %Finalop%,30
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
					msgbox, , Heimdall, %Finalop%,150
				else
				{
					Gui, Destroy
					Gui, +Resize
					Gui, Font, cBlack
					Gui, Add, Text, , %Finalop%
					Gui, Font, cBlue
					;Gui, Add, Text,gGotoSite, %link%
					Gui, Add, link, , <a href="%link%">More</a>
					Gui, Font, cBlack
					Gui, Show, , Heimdall
					Return

					GuiClose:
					GuiEscape:
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
					Run, C:\Program Files\Google\Chrome\Application\chrome.exe "%UserInput%" , max

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

						Run, C:\Program Files\Google\Chrome\Application\chrome.exe "%UserInput%" , max

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
					run, "https://rubikscu.be/"

				Sleep 2000
				send {Tab}{Tab}{Enter}
				Sleep 1000
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
						Run, C:\Program Files\Google\Chrome\Application\chrome.exe "%UserInput%" , max
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

