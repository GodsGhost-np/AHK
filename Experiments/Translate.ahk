


;~ A mouse click makes the tooltip disappear
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

;~ [F12] runs Google Translate for selected text or makes the tooltip with the translation disappear if it is visible

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
ToolTip, Translating... please wait ☺., % A_CaretX-SourceLength, % A_CaretY+50
Target =
Target := GoogleTranslate(Source,LangIn,LangOut)
ToolTip, %Target%, % A_CaretX-SourceLength, % A_CaretY+50
ToolTipVisible = 1
If Paste2CB = 1
    Clipboard = %Target%
Else
    Clipboard = %CurrentCB%
Return

GoogleTranslate(Source,LangIn,LangOut)
{
    StringReplace, Source, Source, %A_Space%%A_Tab%, `%20, All
	
    Base := "translate.google.com/#"
    Path := Base . auto . "/" . en . "/" . Source
    IE := ComObjCreate("InternetExplorer.Application") ;~ Creation of hidden Internet Explorer instance to look up Google Translate and retrieve translation
    IE.Navigate(Path)
    While IE.readyState!=4 || IE.document.readyState!="complete" || IE.busy
            Sleep 50
    Result := IE.document.all.result_box.innertext
    IE.Quit
    Return Result
}