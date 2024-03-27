if 0 != 1 
{
    ; If there is less than 1 argument or more than 1 argument
   Loop Files, %A_ScriptDir%\*.html, R  ; Recurse into subfolders.
	{
		MsgBox, 4, Report Editor ,Do you wish to edit the absolute path of images in the below .html file `n`n Filename = %A_LoopFileFullPath%`n`nContinue?
		IfMsgBox, YES
		{
			FileRead, Content, %A_LoopFileFullPath%
			NewStr := RegExReplace(Content, "img src="`"(.*?)(\w+).jpeg"`"", "img src="`"./$2.jpeg"`"")
			FileDelete, %A_LoopFileFullPath%
			sleep 100
			FileAppend, %NewStr%, %A_LoopFileFullPath%
			sleep 100
			
			
		}

		
	}
}
else
{
	; If more than 1 argument
	
	FileRead, Content, %1%
	NewStr := RegExReplace(Content, "img src="`"(.*?)(\w+).jpeg"`"", "img src="`"./$2.jpeg"`"")
	FileDelete, %1%
	sleep 100
	FileAppend, %NewStr%, %1%
	sleep 100
	
}